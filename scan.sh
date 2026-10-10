#!/bin/sh
# AiRay: see how much space AI coding left on your Mac.
#   curl -fsSL https://airay.jocoding.io/scan.sh | sh
# Downloads the signed airay binary for this Mac's chip to a temporary folder, checks JoCoding's Apple signature, runs
# one read-only scan, then asks before installing anything. /api/cli counts the run (chip, language, country only). The temporary folder is removed when it ends.
set -eu

if [ "$(uname -s)" != "Darwin" ]; then
    echo "AiRay runs on macOS 14 or later."
    exit 1
fi

case " $* " in
    *" --lang ko "*) ko=1 ;;
    *" --lang en "*) ko=0 ;;
    *) if defaults read -g AppleLanguages 2>/dev/null | sed -n 2p | grep -q '"*ko'; then ko=1; else ko=0; fi ;;
esac

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT INT TERM

if [ "$ko" = 1 ]; then printf '  AiRay 스캐너 받는 중...'; else printf '  Getting the AiRay scanner...'; fi
arch="$(uname -m)"
[ "$arch" = "arm64" ] || arch="x86_64"
if [ "$ko" = 1 ]; then lang=ko; else lang=en; fi
curl -fsSL "https://airay.jocoding.io/api/cli?arch=$arch&lang=$lang" | gunzip > "$tmp/airay"
chmod +x "$tmp/airay"
printf '\r\033[2K'

if ! codesign --verify --strict "$tmp/airay" 2>/dev/null || ! codesign -dv "$tmp/airay" 2>&1 | grep -q "TeamIdentifier=N9J2DCAJAX"; then
    echo "The download isn't signed by JoCoding. Stopped."
    exit 1
fi

if (exec < /dev/tty) 2>/dev/null; then
    "$tmp/airay" scan "$@" < /dev/tty
else
    "$tmp/airay" scan --no-install "$@"
fi
