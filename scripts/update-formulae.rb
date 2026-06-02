#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "net/http"
require "uri"

FormulaConfig = Struct.new(
  :name,
  :class_name,
  :path,
  :desc,
  :homepage,
  :repo,
  :artifact_prefix,
  :version_command,
  :caveats,
  keyword_init: true,
)

FORMULAE = [
  FormulaConfig.new(
    name: "agentsview",
    class_name: "Agentsview",
    path: "Formula/agentsview.rb",
    desc: "Local web viewer and analytics for AI coding agent sessions",
    homepage: "https://agentsview.io",
    repo: "kenn-io/agentsview",
    artifact_prefix: "agentsview",
    version_command: "agentsview version",
    caveats: <<~EOS,
      To start the local web UI:
        agentsview serve

      To print token usage summaries:
        agentsview usage daily
    EOS
  ),
  FormulaConfig.new(
    name: "roborev",
    class_name: "Roborev",
    path: "Formula/roborev.rb",
    desc: "Automatic code review daemon for git commits using AI agents",
    homepage: "https://roborev.io",
    repo: "kenn-io/roborev",
    artifact_prefix: "roborev",
    version_command: "roborev version",
    caveats: <<~EOS,
      To initialize roborev in a git repository:
        cd your-repo
        roborev init

      The daemon starts automatically when needed.
      For more info: https://roborev.io/quickstart/
    EOS
  ),
].freeze

PLATFORMS = {
  darwin_amd64: { os: "macos", cpu: "intel" },
  darwin_arm64: { os: "macos", cpu: "arm" },
  linux_amd64: { os: "linux", cpu: "intel" },
  linux_arm64: { os: "linux", cpu: "arm" },
}.freeze

def fetch_json(url)
  uri = URI(url)
  request = Net::HTTP::Get.new(uri)
  request["Accept"] = "application/vnd.github+json"
  request["X-GitHub-Api-Version"] = "2022-11-28"
  request["Authorization"] = "Bearer #{ENV.fetch("GITHUB_TOKEN")}" if ENV["GITHUB_TOKEN"]

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(request)
  end

  raise "GET #{url} failed: #{response.code} #{response.body}" unless response.is_a?(Net::HTTPSuccess)

  JSON.parse(response.body)
end

def current_version(path)
  formula = File.read(path)
  match = formula.match(/^\s*version\s+"([^"]+)"/)
  raise "Could not find version in #{path}" unless match

  match[1]
end

def asset_sha(asset)
  digest = asset.fetch("digest", "")
  return digest.delete_prefix("sha256:") if digest.start_with?("sha256:")

  raise "Asset #{asset.fetch("name")} does not include a SHA-256 digest"
end

def version_segments(version)
  version.split(/[.-]/).map { |segment| segment.match?(/\A\d+\z/) ? segment.to_i : segment }
end

def newer_version?(latest, current)
  latest_segments = version_segments(latest)
  current_segments = version_segments(current)
  max_length = [latest_segments.length, current_segments.length].max

  (0...max_length).each do |index|
    left = latest_segments[index] || 0
    right = current_segments[index] || 0
    next if left == right

    return left.to_s > right.to_s unless left.is_a?(Integer) && right.is_a?(Integer)

    return left > right
  end

  false
end

def release_assets_by_platform(config, release, version)
  assets = release.fetch("assets").to_h { |asset| [asset.fetch("name"), asset] }

  PLATFORMS.to_h do |platform, _metadata|
    filename = "#{config.artifact_prefix}_#{version}_#{platform}.tar.gz"
    asset = assets.fetch(filename) do
      raise "Release #{release.fetch("tag_name")} is missing #{filename}"
    end
    [platform, { url: asset.fetch("browser_download_url"), sha256: asset_sha(asset) }]
  end
end

def render_formula(config, version, assets)
  macos_intel = assets.fetch(:darwin_amd64)
  macos_arm = assets.fetch(:darwin_arm64)
  linux_intel = assets.fetch(:linux_amd64)
  linux_arm = assets.fetch(:linux_arm64)
  caveats = config.caveats.each_line.map { |line| "      #{line}" }.join

  <<~RUBY
    class #{config.class_name} < Formula
      desc "#{config.desc}"
      homepage "#{config.homepage}"
      version "#{version}"
      license "MIT"

      on_macos do
        if Hardware::CPU.intel?
          url "#{macos_intel.fetch(:url)}"
          sha256 "#{macos_intel.fetch(:sha256)}"
        end
        if Hardware::CPU.arm?
          url "#{macos_arm.fetch(:url)}"
          sha256 "#{macos_arm.fetch(:sha256)}"
        end
      end

      on_linux do
        if Hardware::CPU.intel?
          url "#{linux_intel.fetch(:url)}"
          sha256 "#{linux_intel.fetch(:sha256)}"
        end
        if Hardware::CPU.arm?
          url "#{linux_arm.fetch(:url)}"
          sha256 "#{linux_arm.fetch(:sha256)}"
        end
      end

      def install
        bin.install "#{config.name}"
      end

      def caveats
        <<~EOS
    #{caveats.chomp}
        EOS
      end

      test do
        assert_match version.to_s, shell_output("\#{bin}/#{config.version_command}")
      end
    end
  RUBY
end

updated = []

FORMULAE.each do |config|
  release = fetch_json("https://api.github.com/repos/#{config.repo}/releases/latest")
  next if release.fetch("draft") || release.fetch("prerelease")

  latest_version = release.fetch("tag_name").delete_prefix("v")
  installed_version = current_version(config.path)
  next unless newer_version?(latest_version, installed_version)

  assets = release_assets_by_platform(config, release, latest_version)
  File.write(config.path, render_formula(config, latest_version, assets))
  updated << "#{config.name} #{installed_version} -> #{latest_version}"
end

if updated.empty?
  puts "No formula updates available."
else
  puts "Updated formulae:"
  updated.each { |line| puts "  #{line}" }
end
