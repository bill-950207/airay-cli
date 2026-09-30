# AiRay installer

Install [AiRay](https://airay.jocoding.io/?ref=github) from the terminal. AiRay finds what AI coding agents left on your Mac (worktrees, `node_modules`, build folders, caches, session logs) and shows what deleting each one would lose before you clean it up.

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

터미널에서 [AiRay](https://airay.jocoding.io/ko?ref=github)를 설치합니다. AiRay는 AI 코딩 에이전트가 Mac에 남긴 워크트리, `node_modules`, 빌드 폴더, 캐시, 대화 기록을 찾아서, 지우기 전에 잃는 게 있는지 먼저 보여 주는 Mac 앱이에요.

```sh
curl -fsSL https://raw.githubusercontent.com/bill-950207/airay-cli/main/install.sh | sh
```

공증된 DMG를 받아 Gatekeeper로 확인한 뒤 `/Applications`에 설치하고 바로 열어요. macOS 14 이상에서 동작해요.

## License

MIT (this installer). The AiRay app is not open source.
