# SteadySteps — native SwiftUI iOS app

This repository contains a local-first wellness app and an automated GitHub Actions **simulator build**. No Mac is required to trigger the GitHub build.

## Stage 1: Compile for free using GitHub Actions

1. Create a **private** GitHub repository named `SteadySteps` (do not initialize with a README).
2. Unzip the package. Upload the **contents of the `SteadySteps` folder**, including `.github/workflows/ios-build.yml`, `project.yml`, and the inner `SteadySteps/` source folder, to the repository's `main` branch. GitHub's browser uploader may omit hidden folders; verify `.github/workflows/ios-build.yml` appears in the repository. If not, use GitHub's **Add file > Create new file** and enter `.github/workflows/ios-build.yml`, then paste its contents from this package.
3. Go to **Actions > Build SteadySteps (no signing required) > Run workflow**. Pushes to `main` also trigger builds.
4. Watch for the green check mark. The artifact named `SteadySteps-Simulator-Only` proves compilation succeeded, but **cannot be installed on a physical iPhone**.
5. If it fails, open the failed step, copy the compiler errors, and share them for correction.

GitHub Actions usage is subject to your plan's minutes and macOS runner rates. Private-repository usage may consume billable minutes.

## Stage 2: Install on a real iPhone

For a Mac-free native installation, the supported route is generally a **paid Apple Developer Program membership**, Apple code signing, and **TestFlight**. A GitHub Actions simulator artifact is not a signed IPA. Do not upload private signing certificates or App Store Connect API keys to your repository; use GitHub encrypted secrets.

Once the Stage 1 build passes and your Apple Developer membership is active, the next step is to configure an App Store Connect app record, unique bundle identifier, distribution certificate, provisioning profile, and a separate signed TestFlight workflow. That signing workflow is intentionally **not included or claimed to work yet**, since the required Apple account configuration is not available.

## App contents

- Today: habit checklist, movement prompts, and safety reminders
- Move: beginner exercises with safety precautions
- Meals: affordable, no-raw-meat meal instructions and groceries
- Wellness: daily symptom, energy, anxiety, sleep and notes logs
- Trends: recent summaries and charts

Data is stored locally with `UserDefaults` and not synced. The app is not a medical device. Stop activity when dizzy and discuss persistent symptoms with a clinician.
