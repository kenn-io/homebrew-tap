#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: verify-ghosthub-release.sh METADATA_PATH" >&2
  exit 2
fi

if [[ $(uname -s) != "Darwin" || $(uname -m) != "arm64" ]]; then
  echo "Ghosthub release verification requires Apple Silicon macOS" >&2
  exit 1
fi

macos_major=$(sw_vers -productVersion | cut -d. -f1)
if (( macos_major < 26 )); then
  echo "Ghosthub release verification requires macOS 26 or newer" >&2
  exit 1
fi

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
repo_root=$(cd "$script_dir/.." && pwd -P)
metadata_path=$(cd "$(dirname "$1")" && pwd -P)/$(basename "$1")
mise_bin=${MISE_BIN:-mise}

metadata=$(
  cd "$repo_root"
  "$mise_bin" exec --locked -- ruby -I. -rscripts/ghosthub_cask -e '
    release = GhosthubCask.load_metadata(File.read(ARGV.fetch(0)))
    puts [release.url, release.sha256, release.filename, release.version].join("\t")
  ' "$metadata_path"
)
IFS=$'\t' read -r download_url expected_sha filename expected_version <<< "$metadata"

temp_dir=$(mktemp -d "${TMPDIR:-/tmp}/ghosthub-release.XXXXXX")
mountpoint="$temp_dir/mount"
dmg_path="$temp_dir/$filename"
mounted=false

cleanup() {
  if [[ "$mounted" == true ]]; then
    hdiutil detach "$mountpoint" >/dev/null 2>&1 || true
  fi
  rm -rf "$temp_dir"
}
trap cleanup EXIT

mkdir -p "$mountpoint"
curl --fail --silent --show-error --location --output "$dmg_path" "$download_url"

actual_sha=$(shasum -a 256 "$dmg_path" | awk '{print $1}')
if [[ "$actual_sha" != "$expected_sha" ]]; then
  echo "Ghosthub DMG SHA-256 mismatch: expected $expected_sha, got $actual_sha" >&2
  exit 1
fi
echo "Verified Ghosthub DMG SHA-256: $actual_sha"

xcrun stapler validate "$dmg_path"

if ! gatekeeper_output=$(spctl --assess --type open --context context:primary-signature --verbose=4 "$dmg_path" 2>&1); then
  echo "$gatekeeper_output" >&2
  exit 1
fi
echo "$gatekeeper_output"
if [[ "$gatekeeper_output" != *"source=Notarized Developer ID"* ]]; then
  echo "Gatekeeper did not report a Notarized Developer ID DMG" >&2
  exit 1
fi

hdiutil attach -nobrowse -readonly -mountpoint "$mountpoint" "$dmg_path" >/dev/null
mounted=true

app_path="$mountpoint/Ghosthub.app"
app_count=$(find "$mountpoint" -mindepth 1 -maxdepth 1 -type d -name '*.app' -print | wc -l | tr -d ' ')
if [[ "$app_count" != "1" || ! -d "$app_path" ]]; then
  echo "DMG must contain exactly Ghosthub.app at its root" >&2
  exit 1
fi

"$script_dir/verify-ghosthub-app.sh" "$app_path" "$expected_version"

hdiutil detach "$mountpoint" >/dev/null
mounted=false
echo "Verified notarized Ghosthub release: $filename"
