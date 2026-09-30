#!/bin/sh
# Installs AiRay (https://airay.jocoding.io) into /Applications and opens it.
#
#   curl -fsSL https://raw.githubusercontent.com/bill-950207/airay-cli/main/install.sh | sh
#
# Downloads the notarized DMG, checks it with Gatekeeper, copies AiRay.app, opens it. Nothing else is installed.
set -eu

URL="https://airay.jocoding.io/api/download?ref=cli"
BUNDLE_ID="net.jocoding.airay"

say() { printf '%s\n' "$*"; }
die() { printf 'airay: %s\n' "$*" >&2; exit 1; }

[ "$(uname -s)" = Darwin ] || die "AiRay is a Mac app (macOS 14 or later)."
major="$(sw_vers -productVersion | cut -d. -f1)"
[ "$major" -ge 14 ] || die "AiRay needs macOS 14 or later (this Mac has $(sw_vers -productVersion))."

dest="/Applications"
[ -w "$dest" ] || { dest="$HOME/Applications"; mkdir -p "$dest"; }
app="$dest/AiRay.app"

tmp="$(mktemp -d)"
mnt="$tmp/mnt"
cleanup() { hdiutil detach -quiet "$mnt" 2>/dev/null || true; rm -rf "$tmp"; }
trap cleanup EXIT INT TERM

say "Downloading AiRay..."
curl -fL --progress-bar -o "$tmp/AiRay.dmg" "$URL" || die "download failed."

hdiutil attach -quiet -nobrowse -readonly -mountpoint "$mnt" "$tmp/AiRay.dmg" || die "could not open the disk image."
[ -d "$mnt/AiRay.app" ] || die "AiRay.app is missing from the disk image."
spctl --assess --type execute "$mnt/AiRay.app" 2>/dev/null || die "Gatekeeper rejected the app; not installing."

if pgrep -xq AiRay; then
  say "Quitting the running AiRay..."
  osascript -e 'tell application id "net.jocoding.airay" to quit' >/dev/null 2>&1 || true
  sleep 2
fi

say "Installing to $app"
rm -rf "$app"
ditto "$mnt/AiRay.app" "$app"

# Credits a later purchase to this installer (only when no other source was recorded first).
defaults read "$BUNDLE_ID" installRef >/dev/null 2>&1 || defaults write "$BUNDLE_ID" installRef -string cli

open "$app"
say "Done. AiRay is open. It updates itself from now on."
