#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: verify-ghosthub-app.sh APP_PATH" >&2
  exit 2
fi

app_path=$1
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

signature_output=$(codesign -dv --verbose=4 "$app_path" 2>&1)
echo "$signature_output"
if [[ "$signature_output" != *"TeamIdentifier=2YMZH84KR8"* ]]; then
  echo "Ghosthub is not signed by Team Identifier 2YMZH84KR8" >&2
  exit 1
fi

echo "Verified notarized Ghosthub app: bundle=$bundle_id team=2YMZH84KR8"
