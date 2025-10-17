# Initialization

Before using any SDK features, you must ensure that required conditions are met. Call the `initialize` function once your UI is ready. If you call this at start of the app or if you have a single entry point from where you present IA SDK, you can set *isCancellable* to false and user won't be able to pass the prerequisites UI.
```
let options = IASDKInitializationOptions(
    prerequisitesOptions: .init(
        shouldShowIndicator: true, 
        isCancellable: false, 
        isAnimated: true, 
        shouldRunLegal: true, 
        shouldRunOnboarding: true, 
        shouldRunApofinder: true
    )
)
let result = try await IASDK.initialize(options: options)
navigationPath.append(.iaStartScreen)
```

> [!IMPORTANT]
> If you set *isCancellable* to true then prerequisites flow can be cancelled, in that case you must check result before using SDK, as shown in example below.
> If you set it to false, then you don't need to check result because user won't be able to go past prerequisites UI (unless you have multiple entry points).
```
let result = try await IASDK.initialize(options: options)
if result.prerequisitesResult.didAgreeToLegalNotice, result.prerequisitesResult.pharmacyID != nil {
    navigationPath.append(.iaStartScreen)
} else {
    errorMessage = "Initialization failed..."
}   
```

Calling *initialize* will do the following:
* Validate your API key
* Fetch remote configuration (your legal data, feature flags, remote colors etc.)
* Present prerequisites flow: 
    *   **Legal Opt-In (mandatory):** The user must opt in to use the SDK. This is presented first time and when version of some legal document changes.
    
    *   **Onboarding (optional):** An introductory onboarding screen, shown only once.
    
    *   **Apofinder (mandatory):** All products require a pharmacy to be set. You can either:
    
        *   Manually provide a pharmacy identifier to the IA SDK, or
        
        *   Let Prerequisites present **Apofinder**. This will allow user to select pharmacy from list or map.
          
To skip certain steps, use the following code:

```swift
// Marks the legal step as completed so it won't be shown again.
IAIntegrationsSDK.Prerequisites.setIsLegalDisclaimerShown(true)

// Marks the onboarding step as completed so it won't be shown again.
IAIntegrationsSDK.Prerequisites.setIsOnboardingShown(true)

// Manually sets the pharmacy ID. Pass `nil` to clear it.
IASDK.Pharmacy.setPharmacyID(12345)

// Sets pharmacy ID to nil, resets legal documents and onboarding flags.
IAIntegrationsSDK.Prerequisites.resetAllPrerequisites()
```
