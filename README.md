# AiRay

See how much space AI coding left on your Mac. One command, no install:

```sh
curl -fsSL https://airay.jocoding.io/scan.sh | sh
```

It finds worktrees, `node_modules`, build output, Xcode DerivedData and other dev caches, and the logs AI coding agents keep (Claude Code, Codex, Cursor and others). Then it shows how much you can clear, where it is, and which projects have no git remote.

What [`scan.sh`](scan.sh) does:

1. Downloads the `airay` scanner for your Mac's chip from airay.jocoding.io into a temporary folder
2. Checks its Apple signature (JoCoding, Inc., Team ID `N9J2DCAJAX`) and stops if it doesn't match
3. Runs one scan. Desktop, Documents and Downloads are scanned only if you say yes, since macOS asks your terminal for access
4. Asks before installing the [AiRay app](https://airay.jocoding.io/?ref=github), which does the cleaning. The temporary folder is removed when it ends

Each run is counted once, with only the chip type, language and country. The scan results stay in your terminal. Requires macOS 14 or later.

## Install the app directly

```sh
curl -fsSL https://raw.githubusercontent.com/bill-950207/airay-cli/main/install.sh | sh
```

Or with Homebrew:

```sh
brew install --cask bill-950207/tap/airay
```

What [`install.sh`](install.sh) does, and nothing else:

1. Downloads the notarized DMG from airay.jocoding.io
2. Checks it with Gatekeeper (`spctl`) and stops if it is rejected
3. Copies `AiRay.app` to `/Applications` (or `~/Applications` if that is not writable)
4. Opens AiRay. The app updates itself from then on.

Requires macOS 14 or later. Scanning and cleaning one item at a time are free; Pro cleans many at once.

## 한국어

AI 코딩이 Mac에 남긴 용량을 확인해 보세요. 설치 없이 명령어 한 줄이면 돼요.

```sh
curl -fsSL https://airay.jocoding.io/scan.sh | sh
```

워크트리, `node_modules`, 빌드 파일, Xcode DerivedData 같은 개발 캐시, AI 코딩 에이전트(Claude Code, Codex, Cursor 등)가 남긴 기록을 찾아서, 비울 수 있는 용량과 위치, 원격이 없는 프로젝트를 보여 줘요.

1. Mac 칩에 맞는 `airay` 스캐너를 airay.jocoding.io에서 임시 폴더로 받아요
2. Apple 서명(JoCoding, Inc., Team ID `N9J2DCAJAX`)을 확인하고, 다르면 멈춰요
3. 한 번 스캔해요. 데스크탑, 문서, 다운로드 폴더는 macOS가 터미널 접근 권한을 묻기 때문에 허락할 때만 스캔해요
4. 정리를 맡는 [AiRay 앱](https://airay.jocoding.io/ko?ref=github)을 설치할지 물어봐요. 끝나면 임시 폴더는 지워져요

실행할 때마다 칩 종류, 언어, 국가만 담아 한 번 세요. 스캔 결과는 터미널에만 보여요. macOS 14 이상에서 동작해요.

앱만 바로 설치하려면:

```sh
curl -fsSL https://raw.githubusercontent.com/bill-950207/airay-cli/main/install.sh | sh
```

## License

MIT (`scan.sh` and `install.sh`). The `airay` scanner and the AiRay app are not open source.
