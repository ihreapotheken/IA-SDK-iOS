# CardLink Example

This example app demonstrates how to properly implement CardLink functionality following the official IASDK documentation.

## Overview

The CardLink Example app showcases:
- Manual CardLink initialization and flow
- Proper IASDK initialization with prerequisites
- Correct module registration (`.cardLink` and `.integrations` only)
- Using `IASDK.configuration.apiKey` instead of the deprecated `CardLink.authenticationKey`
- Complete NFC setup with permissions and localizations
- Portrait-only orientation support
- Handling all CardLink output actions

## Implementation Highlights

### Modules Registered
As per documentation requirements, this example registers **only**:
- `.integrations` - Required for SDK functionality
- `.cardLink` - CardLink module

### Authentication
✅ Uses `IASDK.configuration.apiKey` (correct approach)
❌ Does NOT use `CardLink.authenticationKey` (legacy/deprecated)

### Prerequisites
- SDK initialization via `IASDK.initialize()` with prerequisites shown
- Prerequisites must be completed before starting CardLink

### Manual CardLink Start
The app demonstrates manual CardLink flow:
1. User taps "Start CardLink" button
2. Creates `CardLinkConfiguration` with:
   - `pharmacyId` from `IASDK.getPharmacyID()`
   - Consent status
   - User information
   - Save card feature enabled
3. Calls `CardLink.start()` with configuration
4. Handles all output actions via closure

## Project Structure

```
CardLinkExample/
├── CardLinkExampleApp.swift          # App entry point with AppDelegate
├── CardLinkExampleViewModel.swift    # SDK initialization & CardLink logic
├── CardLinkExampleDelegate.swift     # SDK & CardLink delegate
├── ContentView.swift                  # UI with "Start CardLink" button
├── LocalizableNFC.xcstrings          # NFC scanning localizations
├── Info.plist                         # NFC permissions
└── CardLinkExample.entitlements      # NFC capability
```

## Setup Instructions

See [SETUP.md](SETUP.md) for detailed setup instructions including:
- Adding SDK package dependencies
- Configuring NFC capabilities
- Setting up Info.plist entries
- Adding API keys and bundle identifier

## NFC Configuration

The app includes complete NFC setup:

### Capability
- Near Field Communication Tag Reading
- Configured in `CardLinkExample.entitlements`

### Info.plist Entries
✅ **NFC Scan Usage Description**: "This app needs NFC access to scan your health card"

✅ **ISO7816 Application Identifiers**: All 10 identifiers required for health card scanning (see Info.plist for complete list)

### Localizations
- `LocalizableNFC.xcstrings` with German and English translations
- All required NFC scanning messages for the health card reading flow

## Orientation Support

The app restricts orientation to portrait mode via `AppDelegate`:

```swift
func application(
    _ application: UIApplication,
    supportedInterfaceOrientationsFor window: UIWindow?
) -> UIInterfaceOrientationMask {
    InterfaceOrientationCoordinator.shared.supportedOrientations
}
```

## CardLink Output Actions

The app handles all CardLink output actions:
- `consentAccepted` - User accepted consent
- `consentDeclined` - User declined consent
- `sessionCreated` - New session created
- `backButtonPressed` - User wants to close CardLink
- `goToCart` - Navigate to cart
- `openTermsAndConditions` - Show T&C
- `prescriptionsRedeemed` - Prescriptions successfully redeemed
- `cardsSaved` - Health cards saved
- `addedPrescriptionsToCart` - Prescriptions added to cart
- `willStartScanning` - NFC scanning about to start
- `failedToInitialize` - Initialization error
- `trackEvent` - Analytics event
- `reopenCardlink` - Reopen CardLink flow

## Running the App

1. Complete the setup steps in [SETUP.md](SETUP.md)
2. Build and run on a **physical iOS device** (NFC doesn't work in simulator)
3. Complete SDK prerequisites when prompted
4. Tap "Start CardLink" to begin the flow
5. Follow on-screen instructions to scan your health card

## Documentation Verification

This example app was created to verify the CardLink documentation is correct and complete. It follows all documented requirements:

- ✅ iOS 15+ support
- ✅ IASDK initialization before CardLink
- ✅ Prerequisites shown before CardLink
- ✅ `.cardLink` module registered
- ✅ NFC capability and permissions configured
- ✅ `LocalizableNFC.xcstrings` included
- ✅ Uses `IASDK.configuration.apiKey` (not `CardLink.authenticationKey`)
- ✅ Proper `CardLinkConfiguration` setup
- ✅ Manual `CardLink.start()` implementation
- ✅ All output actions handled
- ✅ Portrait-only orientation
- ✅ Only `.cardLink` and `.integrations` modules registered

## Notes

- **API Keys**: You must provide your own API key and client ID in `CardLinkExampleViewModel.swift`
- **Bundle ID**: Must be registered with your API key
- **Physical Device**: NFC functionality requires a physical iOS device
- **Health Card**: You need a compatible health card to test the full flow
