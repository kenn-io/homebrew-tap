# frozen_string_literal: true

require "minitest/autorun"
require_relative "../scripts/ghosthub_cask"

class GhosthubCaskTest < Minitest::Test
  VALID_SHA = "1306e0ad875cf62e334f1ffafcd04cb6794193c6d83cb78567514dbb1754949c"

  def release_payload(version: "0.6.0", digest: VALID_SHA, draft: false, prerelease: false)
    tag = "v#{version}"
    filename = "Ghosthub_#{version}_macos_arm64.dmg"
    {
      "tag_name" => tag,
      "draft" => draft,
      "prerelease" => prerelease,
      "assets" => [{
        "name" => filename,
        "browser_download_url" => "https://github.com/kenn-io/ghosthub/releases/download/#{tag}/#{filename}",
        "digest" => "sha256:#{digest}",
      }],
    }
  end

  def valid_release
    GhosthubCask.parse_release(release_payload)
  end

  def assert_release_error(message)
    error = assert_raises(GhosthubCask::ReleaseError) { yield }
    assert_includes error.message, message
  end

  def test_parses_a_valid_stable_release
    release = valid_release

    assert_equal "0.6.0", release.version
    assert_equal "v0.6.0", release.tag_name
    assert_equal "Ghosthub_0.6.0_macos_arm64.dmg", release.filename
    assert_equal "https://github.com/kenn-io/ghosthub/releases/download/v0.6.0/Ghosthub_0.6.0_macos_arm64.dmg", release.url
    assert_equal VALID_SHA, release.sha256
  end

  def test_rejects_drafts_and_prereleases
    assert_release_error("draft") { GhosthubCask.parse_release(release_payload(draft: true)) }
    assert_release_error("prerelease") { GhosthubCask.parse_release(release_payload(prerelease: true)) }
  end

  def test_rejects_malformed_tags
    assert_release_error("tag") { GhosthubCask.parse_release(release_payload(version: "0.6")) }
  end

  def test_requires_one_exact_asset
    payload = release_payload
    payload["assets"] = []
    assert_release_error("exactly one") { GhosthubCask.parse_release(payload) }

    payload = release_payload
    payload["assets"] << payload["assets"].first.dup
    assert_release_error("exactly one") { GhosthubCask.parse_release(payload) }
  end

  def test_requires_a_valid_sha256_digest
    payload = release_payload
    payload["assets"].first.delete("digest")
    assert_release_error("SHA-256") { GhosthubCask.parse_release(payload) }

    assert_release_error("SHA-256") do
      GhosthubCask.parse_release(release_payload(digest: "not-a-digest"))
    end
  end

  def test_requires_the_canonical_asset_url
    payload = release_payload
    payload["assets"].first["browser_download_url"] = "https://example.com/Ghosthub.dmg"
    assert_release_error("URL") { GhosthubCask.parse_release(payload) }

    payload = release_payload
    payload["assets"].first["browser_download_url"] += "?download=1"
    assert_release_error("URL") { GhosthubCask.parse_release(payload) }

    payload = release_payload
    payload["assets"].first["browser_download_url"] =
      "https://github.com/kenn-io/ghosthub/releases/download/v0.5.0/Ghosthub_0.6.0_macos_arm64.dmg"
    assert_release_error("URL") { GhosthubCask.parse_release(payload) }
  end

  def test_compares_numeric_versions
    assert GhosthubCask.newer?("0.6.1", "0.6.0")
    refute GhosthubCask.newer?("0.6.0", "0.6.0")
    refute GhosthubCask.newer?("0.5.9", "0.6.0")
    assert GhosthubCask.newer?("0.10.0", "0.9.9")
  end

  def test_metadata_round_trip_revalidates_fields
    release = valid_release
    assert_equal release, GhosthubCask.load_metadata(GhosthubCask.dump_metadata(release))

    metadata = JSON.parse(GhosthubCask.dump_metadata(release))
    metadata["url"] = "https://example.com/Ghosthub.dmg"
    assert_release_error("URL") { GhosthubCask.load_metadata(JSON.generate(metadata)) }
  end

  def test_renderer_round_trip
    release = valid_release
    rendered = GhosthubCask.render(release)

    assert_equal release, GhosthubCask.parse_current_cask(rendered)
    assert_includes rendered, "auto_updates true"
    assert_includes rendered, "depends_on macos: :tahoe"
    assert_includes rendered, "app \"Ghosthub.app\""
  end

  def test_current_cask_requires_single_version_and_sha256_stanzas
    rendered = GhosthubCask.render(valid_release)
    assert_release_error("version stanza") do
      GhosthubCask.parse_current_cask(rendered.sub("version \"0.6.0\"", "version \"0.6.0\"\n  version \"0.7.0\""))
    end
    assert_release_error("sha256 stanza") do
      GhosthubCask.parse_current_cask(rendered.sub("sha256 \"#{VALID_SHA}\"", "sha256 \"#{VALID_SHA}\"\n  sha256 \"#{VALID_SHA}\""))
    end
  end
end
