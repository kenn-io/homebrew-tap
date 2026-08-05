#!/usr/bin/env ruby
# frozen_string_literal: true

require "net/http"
require_relative "ghosthub_cask"

module GhosthubCaskCLI
  module_function

  def run(arguments)
    command, path, extra = arguments
    raise GhosthubCask::ReleaseError, usage unless command && path && extra.nil?

    case command
    when "current"
      current = GhosthubCask.parse_current_cask(File.read(GhosthubCask::CASK_PATH))
      File.write(path, GhosthubCask.dump_metadata(current))
    when "check"
      File.delete(path) if File.exist?(path)
      candidate = fetch_latest
      current = GhosthubCask.parse_current_cask(File.read(GhosthubCask::CASK_PATH))
      if GhosthubCask.newer?(candidate, current)
        File.write(path, GhosthubCask.dump_metadata(candidate))
        puts "Ghosthub #{candidate.version} is newer than #{current.version}."
      else
        puts "Ghosthub cask is current at #{current.version}."
      end
    when "render"
      candidate = GhosthubCask.load_metadata(File.read(path))
      if File.exist?(GhosthubCask::CASK_PATH)
        current = GhosthubCask.parse_current_cask(File.read(GhosthubCask::CASK_PATH))
        if GhosthubCask.newer?(current, candidate)
          raise GhosthubCask::ReleaseError,
                "refusing to downgrade Ghosthub from #{current.version} to #{candidate.version}"
        end
      end
      File.write(GhosthubCask::CASK_PATH, GhosthubCask.render(candidate))
    else
      raise GhosthubCask::ReleaseError, usage
    end
  end

  def fetch_latest
    uri = URI(GhosthubCask::RELEASE_API)
    request = Net::HTTP::Get.new(uri)
    request["Accept"] = "application/vnd.github+json"
    request["X-GitHub-Api-Version"] = "2022-11-28"
    request["Authorization"] = "Bearer #{ENV.fetch("GITHUB_TOKEN")}" if ENV["GITHUB_TOKEN"]

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.open_timeout = 15
      http.read_timeout = 30
      http.request(request)
    end
    unless response.is_a?(Net::HTTPSuccess)
      raise GhosthubCask::ReleaseError, "GET #{uri} failed with HTTP #{response.code}"
    end

    GhosthubCask.parse_release(JSON.parse(response.body))
  rescue JSON::ParserError => e
    raise GhosthubCask::ReleaseError, "GitHub release response is invalid JSON: #{e.message}"
  end

  def usage
    "usage: update-ghosthub-cask.rb current OUTPUT | check OUTPUT | render INPUT"
  end
end

begin
  GhosthubCaskCLI.run(ARGV)
rescue GhosthubCask::ReleaseError, SystemCallError => e
  warn "ghosthub cask update failed: #{e.message}"
  exit 1
end
