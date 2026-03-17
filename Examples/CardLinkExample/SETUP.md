# CardLink Example Setup Guide

This guide helps you complete the setup for the CardLink Example app.

## Prerequisites

Before running this app, you need to:

1. **Configure API Keys**
   - Open `CardLinkExampleViewModel.swift`
   - Replace `"ENTER YOUR API KEY HERE"` with your actual API key
   - Replace `"ENTER YOUR CLIENT ID HERE"` with your actual client ID

2. **Configure Bundle Identifier**
   - In Xcode, select the CardLinkExample target
   - Go to "Signing & Capabilities"
   - Set a unique Bundle Identifier (not `set.your.bundle.id.here`)
   - Make sure this Bundle ID is registered with your API key

## Xcode Project Configuration

### 1. Add SDK Package Dependencies

1. In Xcode, select the project in the navigator
2. Select the CardLinkExample target
3. Go to "General" tab
4. Under "Frameworks, Libraries, and Embedded Content", add:
   - Click "+" button
   - Add Package Dependency
   - Enter the local package path or GitHub URL
   - Select the following products:
     - `IACardLink`
     - `IAIntegrations`

### 2. Add NFC Capability

1. Select the CardLinkExample target
2. Go to "Signing & Capabilities"
3. Click "+ Capability"
4. Search for "Near Field Communication Tag Reading"
5. Add it to your target

### 3. Configure Info.plist

The Info.plist file is already configured with:

✅ **NFC Scan Usage Description**
- Key: `NSNFCReaderUsageDescription`
- Value: "This app needs NFC access to scan your health card"

✅ **ISO7816 Application Identifiers** (all 10 required identifiers):
- D2760001448000
- D27600014601
- D27600014606
- D27600000102
- A000000167455349474E
- D27600006601
- D27600014602
- E828BD080FA000000167455349474E
- E828BD080FD27600006601
- D27600014603

**No additional configuration needed** - these are already in the `Info.plist` file.

### 4. Add LocalizableNFC.xcstrings to Target

1. In Xcode project navigator, select `LocalizableNFC.xcstrings`
2. In the File Inspector (right panel), make sure "Target Membership" includes CardLinkExample

## Running the App

1. Build and run the app on a physical iOS device (NFC doesn't work in simulator)
2. Complete the SDK prerequisites when prompted
3. Tap "Start CardLink" button to begin the CardLink flow
4. Follow the on-screen instructions to scan your health card

## Implementation Details

This example app demonstrates:

- ✅ IASDK initialization with prerequisites
- ✅ CardLink module registration (`.cardLink` and `.integrations`)
- ✅ Manual CardLink start using `CardLink.start()`
- ✅ Proper configuration using `CardLinkConfiguration`
- ✅ Using `IASDK.configuration.apiKey` (not `CardLink.authenticationKey`)
- ✅ Handling CardLink output actions
- ✅ NFC setup with proper permissions and localizations
- ✅ Portrait-only orientation support

## Files Created

- `CardLinkExampleApp.swift` - App entry point with orientation coordinator
- `CardLinkExampleViewModel.swift` - Handles SDK initialization and CardLink flow
- `CardLinkExampleDelegate.swift` - SDK and CardLink delegate implementation
- `ContentView.swift` - UI with "Start CardLink" button
- `LocalizableNFC.xcstrings` - NFC scanning localizations
