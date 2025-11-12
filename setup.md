## Run locally

These steps explain how to clone this repository and run the iOS SwiftUI app locally on a Mac with Xcode. This project contains a SwiftUI MVVM scaffold that uses the Jikan API (https://api.jikan.moe/v4) to search for anime.

Prerequisites
- macOS with Xcode 13 or newer (Xcode 14/15 recommended)
- Git and basic terminal skills

1) Clone the repository

```bash
# macOS / Linux / WSL / PowerShell
git clone https://github.com/sumant11112004/hritik-ass.git
cd hritik-ass
```

2) Option A — Open in Xcode and run (recommended)

- Open Xcode and create a new iOS App project (File → New → Project → iOS → App). Choose SwiftUI and Swift as language.
- In Finder, open the cloned repo folder and drag the Swift source files from `Sources/AnimeExplorerApp/` into the Xcode project navigator. When prompted, choose "Copy items if needed" and select the app target.
- Set the deployment target to iOS 15 or newer (Project → Info → Deployment Target).
- Choose an iPhone Simulator in Xcode's toolbar and press Run (⌘R).

3) Option B — Use an existing Xcode project in the repo (if present)

- If an Xcode project or workspace already exists in the repo (e.g., `AnimeExplorer.xcodeproj`), open it with:

```bash
open AnimeExplorer.xcodeproj
```

- Then select a simulator and Run.

4) Build from terminal (advanced)

- If you have an Xcode project and scheme, you can build from terminal using `xcodebuild`:

```bash
# Replace project/scheme/destination as appropriate
xcodebuild -project AnimeExplorer.xcodeproj -scheme AnimeExplorerApp -destination 'platform=iOS Simulator,name=iPhone 14' clean build
```

Notes about running on Windows
- You cannot run the iOS Simulator or build iOS apps natively on Windows. Use a Mac, a cloud macOS runner (GitHub Actions, MacStadium), or a macOS VM.

CI / GitHub Actions (optional)

If you want to build on push using GitHub Actions (macOS runner), add `.github/workflows/ci.yml` with a job that runs on `macos-latest` and uses `xcodebuild` to build the project. The scaffold currently provides Swift sources; you will still need an Xcode project or workspace to run `xcodebuild`.

Troubleshooting
- If you see missing symbol or framework errors, confirm files are added to the app target in Xcode.
- If `AsyncImage` or other APIs are not found, set the deployment target to iOS 15+ and use a recent Xcode version.

Questions or next steps
- Want me to create an Xcode project file in this repo so the app can be built by `xcodebuild` and CI? I can add one and a GitHub Actions workflow.
- Want me to add a README `Run` section as well? I can update `readme.md` too.
