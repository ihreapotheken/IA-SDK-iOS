# Initialization

Before using any SDK features, you must ensure that required conditions are met. Call the `initialize` function once your UI is ready. This is the basic case. In the sections below, we’ll cover more advanced scenarios.
```
let prerequisitesOptions = IASDKPrerequisitesOptions(
    isCancellable: true, 
    isAnimated: true,
    shouldRunLegal: true,
    shouldRunOnboarding: true, 
    shouldRunApofinder: true
)
let _ = try await IASDK.initialize(shouldShowIndicator: true, prerequisitesOptions: prerequisitesOptions)
// We have to check result only if `isCancellable` flag is true.
if let prerequisitesResult = result.prerequisitesResult, !prerequisitesResult.isCancelled {
    // Proceed with SDK, e.g. navigationPath.append(.iaStartScreen)
}
```

Calling *initialize* will do the following:
* Validate your API key and fetch entitlements for modules.
* Fetch remote configuration (your legal data, feature flags, remote colors etc.)
* Present prerequisites screens (only if *prerequisitesOptions* is set):
    *   **Onboarding:** An introductory onboarding screen, shown only once. Onboarding is optional, you can set *shouldRunOnboarding* to skip it.
    *   **Legal Opt-In:** The user must opt in to use the SDK. This is presented first time and when version of some legal document changes. Legal screens are optional, you can set *shouldRunLegal* to skip it.
    *   **Apofinder:** SDK require a pharmacy to be set. It cannot run without one. You can provide pharmacy in two ways:
        *   Manually provide a pharmacy identifier to the IA SDK before you call initialize, it will be fetched and validated as part of prerequisites. Use `IASDK.Pharmacy.savePharmacyID(...)` to save pharmacy ID before initialization.
        *   Let Prerequisites present **Apofinder**. This will allow user to select pharmacy from list or map.
* Preload data, e.g. it will preload Cart so that it is available on all screens.

## Initialization and prerequisites explained
The initialization process can be divided into two key parts:
- SDK initialization: Fetches and configures essential components of the SDK. This step has no UI, except for a loading indicator.
- Prerequisites: A flow of screens that runs only when necessary. While onboarding and legal steps are optional, this phase ensures that the pharmacy is set — which is mandatory.

*IASDK.initialize* function handles both initialization and prerequisites.
The prerequisites flow runs only if *prerequisitesOptions* is provided. However, it’s important to note that **you always must call initialize with *prerequisitesOptions* before using the SDK, even if you initialized it earlier without them**.

This design allows flexibility: in some cases, you may want to initialize the SDK first and present the prerequisites screens later. In such cases, you can call initialize twice — first without prerequisitesOptions, and then again with them.

Regardless of how many times you call initialize, the SDK initialization runs only once, while the prerequisites flow runs every time it’s triggered (screens are presented only if needed, first time or something changed).

## Automatic initialization
You can enable automatic initialization by setting the following configuration options:
```
IASDK.configuration.isAutoInitializationEnabled = true
IASDK.configuration.defaultInitializationOptions = .init(
    shouldShowIndicator: false, 
    prerequisitesOptions: .init(
        isCancellable: false, 
        isAnimated: true,
        shouldRunLegal: true,
        shouldRunOnboarding: true,
        shouldRunApofinder: true
    )
)
```
With this configuration, the initialize function will run automatically when you display any SDK screen.
However, it’s important to note that automatic initialization only occurs when a screen is presented. If you call any SDK function that requires initialization or prerequisites before showing a screen, an error will be thrown.

## Cancellable and Non-cancellable prerequisites
- Controlled by `IASDKPrerequisitesOptions.isCancellable` flag (passed in `IASDK.initialize` function).
- Cancellable: There is dismiss ("X") button on every screen, tapping that button will cancel the prerequisites flow. Host app must check the initialization result and if prerequisites is cancelled then it must not show any IASDK components.
```
let result = try await IASDK.initialize(shouldShowIndicator: true, prerequisitesOptions: prerequisitesOptions)
if let prerequisitesResult = result.prerequisitesResult, !prerequisitesResult.isCancelled {
    // Proceed, e.g. navigationPath.append(.iaStartScreen)
}
```
- Non-cancellable: There is dismiss ("X") button only on Onboarding screen but that doesn't cacnel the prerequisites flow, it only skips onboarding. Other screens don't have dismiss button meaning SDK will not allow user to go back or cancel the prerequisites.

## Common scenarios
Here we will cover some common scenarios and how to best handle initialization and prerequisites.

**Scenario 1:** IA SDK is vital part of your app and you don't mind that prerequisites screens are run when app starts.  
Simply run *initialize* function with *prerequsitesOptions* at start. You can then use IA SDK screens and functions as you wish.  
If something fails, you must handle it at start.

**Scenario 2:** You run IA SDK from single entry point and don't use any IA SDK functions before.  
In this case you can run *initialize* function with *prerequsitesOptions* just before you enter part of your app where IA SDK is used.   
If something fails you can handle at SDK entry point, not at the start of your app.  
Note: There might be few simple functions that you can call before initialization is run but those are exceptions. 

**Scenario 3:** You run IA SDK from single entry point but you might call some IA SDK functions before it.  
In this case you can run *initialize* function without *prerequsitesOptions* at start of your app. Then, just before you enter part of your app where IA SDK is used, call *initialize* again with *prerequsitesOptions* set.  
Note: This should be true for most functions, but if some function requires pharmacy to be set then you will have to call *initialize* with *prerequsitesOptions* before.


## Other
To skip certain steps, use the following code:

```swift
// Mark the legal documents as not accepted.
try await IASDK.Prerequisites.resetLegalDisclaimer()

// Marks the onboarding step as completed so it won't be shown again.
try await IASDK.Prerequisites.setIsOnboardingShown(true)

// Sets pharmacy ID to nil, resets legal documents and onboarding flags.
try await IASDK.Prerequisites.resetAllPrerequisites()

// Clean Prerequisites cache
IASDK.cleanCache(initialization: false, prerequisites: true)

// Manually sets the pharmacy ID. Pass `nil` to clear it.
IASDK.Pharmacy.savePharmacyID(12345)
```
