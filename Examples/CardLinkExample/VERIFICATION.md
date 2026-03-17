# CardLink Example - Documentation Verification Checklist

This document verifies that the CardLink Example implementation correctly follows all requirements from the IACardLink documentation.

## Requirements Verification

### ✅ iOS 15+ Support
**Requirement**: iOS 15+
**Implementation**: Configured in project settings
**Status**: ✅ VERIFIED

### ✅ SDK Initialization
**Requirement**: The IASDK must be initialized by calling IASDK.initialize()
**Implementation**: `CardLinkExampleViewModel.swift:54`
```swift
let result = try await IASDK.initialize(options: options)
```
**Status**: ✅ VERIFIED

### ✅ Prerequisites Shown
**Requirement**: All SDK prerequisites must be completed before starting CardLink
**Implementation**: `CardLinkExampleViewModel.swift:47-53` with prerequisitesOptions
```swift
let options = IASDKInitializationOptions(
    prerequisitesOptions: .init(
        shouldShowIndicator: true,
        isCancellable: false,
        isAnimated: true
    )
)
```
**Status**: ✅ VERIFIED

### ✅ Module Registration
**Requirement**: The .cardlink module must be registered using IASDKModule.cardLink.register()
**Requirement**: Only .cardLink and .integrations modules should be registered
**Implementation**: `CardLinkExampleViewModel.swift:26-29`
```swift
IASDK.register([
    .integrations,
    .cardLink
])
```
**Status**: ✅ VERIFIED - Only these two modules are registered

### ✅ NFC Capability
**Requirement**: Add "Near Field Communication Tag Reading" capability
**Implementation**: `CardLinkExample.entitlements`
```xml
<key>com.apple.developer.nfc.readersession.formats</key>
<array>
    <string>TAG</string>
</array>
```
**Status**: ✅ VERIFIED

### ✅ NFC Usage Description
**Requirement**: Add Privacy - NFC Scan Usage Description to Info.plist
**Implementation**: `Info.plist:5-6`
```xml
<key>NSNFCReaderUsageDescription</key>
<string>This app needs NFC access to scan your health card</string>
```
**Status**: ✅ VERIFIED

### ✅ ISO7816 Application Identifiers
**Requirement**: Add all 10 required ISO7816 application identifiers
**Implementation**: `Info.plist:7-19` - All 10 identifiers present (D2760001448000, D27600014601, D27600014606, D27600000102, A000000167455349474E, D27600006601, D27600014602, E828BD080FA000000167455349474E, E828BD080FD27600006601, D27600014603)

**Status**: ✅ VERIFIED - All identifiers properly configured in Info.plist

### ✅ LocalizableNFC.xcstrings
**Requirement**: Add LocalizableNFC.xcstrings file to main target
**Implementation**: `LocalizableNFC.xcstrings` with all required strings
**Status**: ✅ VERIFIED

### ✅ Authentication Key
**Requirement**: Use IASDK.configuration.apiKey (Do NOT use CardLink.authenticationKey)
**Implementation**: `CardLinkExampleViewModel.swift:23`
```swift
IASDK.configuration.apiKey = "ENTER YOUR API KEY HERE"
```
**Status**: ✅ VERIFIED - Uses correct API key approach, NOT CardLink.authenticationKey

### ✅ CardLinkConfiguration
**Requirement**: Properly configure CardLinkConfiguration with required parameters
**Implementation**: `CardLinkExampleViewModel.swift:71-81`
```swift
let configuration = CardLinkConfiguration(
    pharmacyId: pharmacyId,              // from IASDK.getPharmacyID()
    consentStatus: .undetermined,        // Show consent screen
    canCode: nil,                        // Optional
    phoneNumber: "",                     // Required
    userId: "example_user_123",          // Required for saving cards
    cardName: nil,                       // Optional
    isSaveCardEnabled: true,             // Enable save card feature
    source: .unknown,                    // Optional
    appID: nil                           // Optional
)
```
**Status**: ✅ VERIFIED - All required parameters present

### ✅ Pharmacy ID from SDK
**Requirement**: pharmacyId should use value returned from IASDK.getPharmacyID
**Implementation**: `CardLinkExampleViewModel.swift:66`
```swift
guard let pharmacyId = IASDK.getPharmacyID() else {
    print("Pharmacy ID is not available")
    return
}
```
**Status**: ✅ VERIFIED

### ✅ Manual CardLink Start
**Requirement**: Start CardLink manually by calling CardLink.start
**Implementation**: `CardLinkExampleViewModel.swift:83-90`
```swift
CardLink.start(
    type: .startCardlink,
    forcePresent: false,
    on: rootViewController,
    configuration: configuration
) { [weak self] action in
    self?.handleCardLinkAction(action)
}
```
**Status**: ✅ VERIFIED

### ✅ Handle All Output Actions
**Requirement**: Handle all CardLinkOutputAction cases
**Implementation**: `CardLinkExampleViewModel.swift:93-135`
All actions handled:
- ✅ consentAccepted
- ✅ consentDeclined
- ✅ sessionCreated
- ✅ backButtonPressed (calls CardLink.finish())
- ✅ goToCart
- ✅ openTermsAndConditions
- ✅ prescriptionsRedeemed
- ✅ cardsSaved
- ✅ addedPrescriptionsToCart
- ✅ willStartScanning
- ✅ failedToInitialize
- ✅ trackEvent
- ✅ reopenCardlink

**Status**: ✅ VERIFIED

### ✅ Orientation Support
**Requirement**: CardLink can run only in portrait mode, restrict from AppDelegate
**Implementation**: `CardLinkExampleApp.swift:30-36`
```swift
private class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        InterfaceOrientationCoordinator.shared.supportedOrientations
    }
}
```
**Status**: ✅ VERIFIED

### ✅ UI Implementation
**Requirement**: App should have button that starts CardLink manually
**Implementation**: `ContentView.swift:31-42`
```swift
Button(action: {
    startCardLink()
}) {
    Text("Start CardLink")
        .font(.headline)
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(10)
}
```
