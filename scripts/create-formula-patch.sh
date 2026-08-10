#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  printf 'usage: %s PATCH_FILE\n' "${0##*/}" >&2
  exit 2
fi

patch_file=$1
git add --intent-to-add -- Formula/*.rb
git diff --binary -- Formula > "$patch_file"
