# Initialization

Before using any SDK features, you must ensure that required conditions are met. Call the `initialize` function once your UI is ready. This is the basic case. In the sections below, we’ll cover more advanced scenarios.
```
let prerequisitesOptions = IASDKPrerequisitesOptions(
    shouldShowIndicator: true, 
    isCancellable: false, 
    isAnimated: true,
    shouldRunLegal: true,
    shouldRunOnboarding: true, 
    shouldRunApofinder: true
)
let _ = try await IASDK.initialize(shouldShowIndicator: true, prerequisitesOptions: prerequisitesOptions)
navigationPath.append(.iaStartScreen)
```

Calling *initialize* will do the following:
* Validate your API key and fetch entitlements for modules.
* Fetch remote configuration (your legal data, feature flags, remote colors etc.)
* Present prerequisites screens (only if *prerequisitesOptions* is set):
    *   **Onboarding (optional):** An introductory onboarding screen, shown only once. Onboarding is optional, you can set *shouldRunOnboarding* to skip it.
    *   **Legal Opt-In (mandatory):** The user must opt in to use the SDK. This is presented first time and when version of some legal document changes. Legal screens are optional, you can set *shouldRunLegal* to skip it.
    *   **Apofinder (mandatory):** SDK require a pharmacy to be set. It cannot run without one. You can provide pharmacy in two ways:
        *   Manually provide a pharmacy identifier to the IA SDK before you call initialize, it will be fetched and validated as part of prerequisites.
        *   Let Prerequisites present **Apofinder**. This will allow user to select pharmacy from list or map.
* Preload data, e.g. it will preload Cart so that it is available on all screens.

## Initialization and prerequisites explained
The initialization process can be divided into two key parts:
- SDK initialization: Fetches and configures essential components of the SDK. This step has no UI, except for a loading indicator.
- Prerequisites: A flow of screens that runs only when necessary. While onboarding and legal steps are optional, this phase ensures that the pharmacy is set — which is mandatory.

*IASDK.initialize* function handles both initialization and prerequisites.
The prerequisites flow runs only if *prerequisitesOptions* is provided. However, it’s important to note that you must call initialize with *prerequisitesOptions* before using the SDK, even if you initialized it earlier without them.

This design allows flexibility: in some cases, you may want to initialize the SDK first and present the prerequisites screens later. In such cases, you can call initialize twice — first without prerequisitesOptions, and then again with them.

Regardless of how many times you call initialize, the SDK initialization runs only once, while the prerequisites flow runs every time it’s triggered.

## Automatic initialization
You can enable automatic initialization by setting the following configuration option:
```
IASDK.configuration.initializationType = .automatic(
    options: .init(
        shouldShowIndicator: true,
        prerequisitesOptions: prerequisitesOptions
    )
)
```
With this configuration, the initialize function will run automatically when you display any SDK screen.
However, it’s important to note that automatic initialization only occurs when a screen is presented. If you call any SDK function that requires initialization or prerequisites before showing a screen, an error will be thrown.

## Other
To skip certain steps, use the following code:

```swift
// Mark the legal documents as not accepted.
IASDK.Prerequisites.resetLegalDisclaimer()

// Marks the onboarding step as completed so it won't be shown again.
IASDK.Prerequisites.setIsOnboardingShown(true)

// Sets pharmacy ID to nil, resets legal documents and onboarding flags.
IASDK.Prerequisites.resetAllPrerequisites()

// Manually sets the pharmacy ID. Pass `nil` to clear it.
IASDK.Pharmacy.setPharmacyID(12345)
```
