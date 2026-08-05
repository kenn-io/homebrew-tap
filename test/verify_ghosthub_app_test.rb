# frozen_string_literal: true

require "fileutils"
require "minitest/autorun"
require "open3"
require "tmpdir"

class VerifyGhosthubAppTest < Minitest::Test
  SCRIPT = File.expand_path("../scripts/verify-ghosthub-app.sh", __dir__)

  def run_verifier(signature_details)
    Dir.mktmpdir("verify-ghosthub-app") do |directory|
      app_path = File.join(directory, "Ghosthub.app")
      contents_path = File.join(app_path, "Contents")
      bin_path = File.join(directory, "bin")
      FileUtils.mkdir_p(contents_path)
      FileUtils.mkdir_p(bin_path)
      File.write(
        File.join(contents_path, "Info.plist"),
        <<~PLIST,
          <?xml version="1.0" encoding="UTF-8"?>
          <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
          <plist version="1.0">
          <dict>
            <key>CFBundleIdentifier</key>
            <string>com.ghosthub</string>
          </dict>
          </plist>
        PLIST
      )
      write_executable(
        File.join(bin_path, "codesign"),
        <<~SH,
          #!/usr/bin/env bash
          if [[ "$1" == "--verify" ]]; then
            exit 0
          fi
          printf '%s\n' "$FAKE_CODESIGN_DETAILS" >&2
        SH
      )
      write_executable(
        File.join(bin_path, "spctl"),
        <<~SH,
          #!/usr/bin/env bash
          echo "$4: accepted"
          echo "source=Notarized Developer ID"
        SH
      )

      Open3.capture3(
        {
          "PATH" => "#{bin_path}:#{ENV.fetch("PATH")}",
          "FAKE_CODESIGN_DETAILS" => signature_details,
        },
        SCRIPT,
        app_path,
      )
    end
  end

  def write_executable(path, contents)
    File.write(path, contents)
    FileUtils.chmod(0o755, path)
  end

  def test_rejects_team_identifier_substring_in_another_field
    _stdout, stderr, status = run_verifier(<<~DETAILS)
      Identifier=com.ghosthub
      Authority=Fake TeamIdentifier=2YMZH84KR8
      TeamIdentifier=ATTACKER123
    DETAILS

    refute status.success?
    assert_includes stderr, "unexpected signing Team Identifier"
  end

  def test_rejects_a_mismatched_signed_bundle_identifier
    _stdout, stderr, status = run_verifier(<<~DETAILS)
      Identifier=not.ghosthub
      TeamIdentifier=2YMZH84KR8
    DETAILS

    refute status.success?
    assert_includes stderr, "unexpected signed bundle identifier"
  end

  def test_accepts_exact_signing_identity_fields
    stdout, stderr, status = run_verifier(<<~DETAILS)
      Identifier=com.ghosthub
      TeamIdentifier=2YMZH84KR8
    DETAILS

    assert status.success?, stderr
    assert_includes stdout, "bundle=com.ghosthub team=2YMZH84KR8"
  end
end
