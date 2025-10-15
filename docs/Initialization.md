# Initialization

Before using any SDK features, you must ensure that required conditions are met. Call the `initialize` function once your UI is ready:

```swift
let result = try await IASDK.initialize(options: .init(shouldShowIndicator: true, isCancellable: false, isAnimated: false))
```

Among other things, this will start the prerequisites flow if needed, it consists of three separate screens:

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
```
