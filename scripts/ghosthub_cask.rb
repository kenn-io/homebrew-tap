# frozen_string_literal: true

require "json"
require "uri"

module GhosthubCask
  REPOSITORY = "kenn-io/ghosthub"
  CASK_PATH = "Casks/ghosthub.rb"
  RELEASE_API = "https://api.github.com/repos/#{REPOSITORY}/releases/latest"
  TAG_PATTERN = /\Av(\d+)\.(\d+)\.(\d+)\z/
  VERSION_PATTERN = /\A(\d+)\.(\d+)\.(\d+)\z/
  SHA256_PATTERN = /\A[0-9a-f]{64}\z/
  BUNDLE_ID = "com.ghosthub"
  TEAM_ID = "2YMZH84KR8"

  class ReleaseError < StandardError; end

  Release = Data.define(:version, :tag_name, :filename, :url, :sha256)

  module_function

  def parse_release(payload)
    raise ReleaseError, "latest release is a draft" unless payload.fetch("draft") == false
    raise ReleaseError, "latest release is a prerelease" unless payload.fetch("prerelease") == false

    tag_name = payload.fetch("tag_name")
    match = TAG_PATTERN.match(tag_name)
    raise ReleaseError, "release tag #{tag_name.inspect} must be vX.Y.Z" unless match

    version = match.captures.join(".")
    filename = canonical_filename(version)
    assets = payload.fetch("assets")
    raise ReleaseError, "release assets must be an array" unless assets.is_a?(Array)

    matching_assets = assets.select { |asset| asset.is_a?(Hash) && asset["name"] == filename }
    unless matching_assets.one?
      raise ReleaseError, "release must contain exactly one #{filename} asset"
    end

    asset = matching_assets.first
    digest = asset.fetch("digest", "")
    sha256 = digest.delete_prefix("sha256:").downcase if digest.start_with?("sha256:")
    unless sha256&.match?(SHA256_PATTERN)
      raise ReleaseError, "#{filename} must include a valid SHA-256 digest"
    end

    build_release(
      version: version,
      tag_name: tag_name,
      filename: filename,
      url: asset.fetch("browser_download_url"),
      sha256: sha256,
    )
  rescue KeyError => e
    raise ReleaseError, "release metadata is missing #{e.key.inspect}"
  end

  def build_release(version:, tag_name:, filename:, url:, sha256:)
    unless version.is_a?(String) && version.match?(VERSION_PATTERN)
      raise ReleaseError, "version #{version.inspect} must be X.Y.Z"
    end

    expected_tag = "v#{version}"
    raise ReleaseError, "tag #{tag_name.inspect} does not match #{expected_tag}" unless tag_name == expected_tag

    expected_filename = canonical_filename(version)
    unless filename == expected_filename
      raise ReleaseError, "filename #{filename.inspect} does not match #{expected_filename}"
    end

    validate_url!(url, tag_name, filename)
    normalized_sha = sha256.to_s.downcase
    raise ReleaseError, "SHA-256 digest is invalid" unless normalized_sha.match?(SHA256_PATTERN)

    Release.new(
      version: version,
      tag_name: tag_name,
      filename: filename,
      url: url,
      sha256: normalized_sha,
    )
  end

  def parse_current_cask(text)
    versions = text.scan(/^\s*version\s+"([^"]+)"\s*$/).flatten
    raise ReleaseError, "cask must contain exactly one version stanza" unless versions.one?

    checksums = text.scan(/^\s*sha256\s+"([^"]+)"\s*$/).flatten
    raise ReleaseError, "cask must contain exactly one sha256 stanza" unless checksums.one?

    version = versions.first
    build_release(
      version: version,
      tag_name: "v#{version}",
      filename: canonical_filename(version),
      url: canonical_url(version),
      sha256: checksums.first,
    )
  end

  def newer?(candidate, current)
    candidate_version = candidate.respond_to?(:version) ? candidate.version : candidate
    current_version = current.respond_to?(:version) ? current.version : current
    candidate_segments = version_segments(candidate_version)
    current_segments = version_segments(current_version)
    (candidate_segments <=> current_segments).positive?
  end

  def dump_metadata(release)
    validated = build_release(**release.to_h)
    JSON.pretty_generate(validated.to_h.transform_keys(&:to_s)) << "\n"
  end

  def load_metadata(text)
    metadata = JSON.parse(text)
    raise ReleaseError, "release metadata must be a JSON object" unless metadata.is_a?(Hash)

    expected_keys = %w[version tag_name filename url sha256]
    unless metadata.keys.sort == expected_keys.sort
      raise ReleaseError, "release metadata must contain exactly #{expected_keys.join(", ")}"
    end

    build_release(**metadata.transform_keys(&:to_sym))
  rescue JSON::ParserError => e
    raise ReleaseError, "release metadata is invalid JSON: #{e.message}"
  end

  def render(release)
    validated = build_release(**release.to_h)
    <<~RUBY
      cask "ghosthub" do
        version "#{validated.version}"
        sha256 "#{validated.sha256}"

        url "https://github.com/kenn-io/ghosthub/releases/download/v\#{version}/Ghosthub_\#{version}_macos_arm64.dmg",
            verified: "github.com/kenn-io/ghosthub/"
        name "Ghosthub"
        desc "Native terminal for local and remote tmux fleets"
        homepage "https://ghosthub.ai/"

        livecheck do
          url :url
          strategy :github_latest
        end

        auto_updates true
        depends_on arch: :arm64
        depends_on macos: :tahoe

        app "Ghosthub.app"

        zap trash: [
          "~/.config/ghosthub",
          "~/.ghosthub",
          "~/Library/Caches/com.ghosthub",
          "~/Library/HTTPStorages/com.ghosthub",
          "~/Library/Preferences/com.ghosthub.plist",
          "~/Library/Saved Application State/com.ghosthub.savedState",
          "~/Library/WebKit/com.ghosthub",
        ]
      end
    RUBY
  end

  def canonical_filename(version)
    "Ghosthub_#{version}_macos_arm64.dmg"
  end

  def canonical_url(version)
    "https://github.com/#{REPOSITORY}/releases/download/v#{version}/#{canonical_filename(version)}"
  end

  def validate_url!(url, tag_name, filename)
    uri = URI(url)
    expected_path = "/#{REPOSITORY}/releases/download/#{tag_name}/#{filename}"
    valid = uri.scheme == "https" && uri.host == "github.com" && uri.path == expected_path &&
      uri.query.nil? && uri.fragment.nil? && uri.userinfo.nil?
    raise ReleaseError, "asset URL #{url.inspect} is not canonical" unless valid
  rescue URI::InvalidURIError
    raise ReleaseError, "asset URL #{url.inspect} is invalid"
  end

  def version_segments(version)
    match = VERSION_PATTERN.match(version.to_s)
    raise ReleaseError, "version #{version.inspect} must be X.Y.Z" unless match

    match.captures.map(&:to_i)
  end
end
