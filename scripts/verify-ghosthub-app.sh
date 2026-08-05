#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "usage: verify-ghosthub-app.sh APP_PATH EXPECTED_VERSION" >&2
  exit 2
fi

app_path=$1
expected_version=$2
if [[ ! "$expected_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "invalid expected Ghosthub version: $expected_version" >&2
  exit 2
fi

if [[ ! -d "$app_path" || ! -f "$app_path/Contents/Info.plist" ]]; then
  echo "Ghosthub app bundle not found at $app_path" >&2
  exit 1
fi

if ! codesign_output=$(codesign --verify --deep --strict --verbose=4 "$app_path" 2>&1); then
  echo "$codesign_output" >&2
  exit 1
fi
echo "$codesign_output"

if ! gatekeeper_output=$(spctl --assess --type execute --verbose=4 "$app_path" 2>&1); then
  echo "$gatekeeper_output" >&2
  exit 1
fi
echo "$gatekeeper_output"
if [[ "$gatekeeper_output" != *"source=Notarized Developer ID"* ]]; then
  echo "Gatekeeper did not report a Notarized Developer ID app" >&2
  exit 1
fi

bundle_id=$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$app_path/Contents/Info.plist")
if [[ "$bundle_id" != "com.ghosthub" ]]; then
  echo "unexpected Ghosthub bundle identifier: $bundle_id" >&2
  exit 1
fi

app_version=$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$app_path/Contents/Info.plist")
if [[ "$app_version" != "$expected_version" ]]; then
  echo "unexpected Ghosthub app version: expected $expected_version, got $app_version" >&2
  exit 1
fi

build_version=$(/usr/libexec/PlistBuddy -c 'Print :CFBundleVersion' "$app_path/Contents/Info.plist")
if [[ ! "$build_version" =~ ^[0-9]+$ ]]; then
  echo "invalid Ghosthub app build version: $build_version" >&2
  exit 1
fi

signature_output=$(codesign -dv --verbose=4 "$app_path" 2>&1)
echo "$signature_output"
signed_bundle_id=$(printf '%s\n' "$signature_output" | sed -n 's/^Identifier=//p')
if [[ "$signed_bundle_id" != "com.ghosthub" ]]; then
  echo "unexpected signed bundle identifier: $signed_bundle_id" >&2
  exit 1
fi

team_id=$(printf '%s\n' "$signature_output" | sed -n 's/^TeamIdentifier=//p')
if [[ "$team_id" != "2YMZH84KR8" ]]; then
  echo "unexpected signing Team Identifier: $team_id" >&2
  exit 1
fi

echo "Verified notarized Ghosthub app: bundle=$bundle_id version=$app_version build=$build_version team=2YMZH84KR8"
