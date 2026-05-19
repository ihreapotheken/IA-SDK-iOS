# IARedeemPrescriptionScreen

Screen for redeeming prescriptions and adding them to the cart (optional).

The `.cardLink` and `.prescription` modules are optional — unavailable options are hidden. If neither is registered, the screen will be empty.

This screens shows following UI for redeeming prescriptions:
- CardLink (requires `.cardLink` module): read electronic health card via NFC.
- Photo capture (requires `.prescription` module): take a photo of a prescription or choose from gallery.
- QR code scanning (requires `.prescription` module): scan a prescription QR code.

Prescriptions will be uploaded to cart only if `.ordering` module is registered.

Host app can use following methods in `SDKDelegate` to override default behavior:
  - `didScanPrescription`: Read documentation for `IAPrescriptionScanResult`.
  - `didScanEPrescription`: Read documentation for `IAPrescriptionScanResult`.
  - `cardLinkDidSendAction`: Action `addedPrescriptionsToCart` is sent when prescriptions are redeemed via cart.
  - `sdkWillNavigateToTarget`: Both prescription and cardlink flows show bottom sheet that let user go to cart screen when prescription is uploaded.
                               You can override it to navigate to cart inside your view hieararchy (Otherwise cart will be presented above everything).
                               
You can use these delegate methods to prevent default behavior (uploading to cart).
You can also these delegate methods to get prescription data if you are not using `.ordering` module.

## Overview
- Module: `IACore`
- Dependencies:
  - `IAPrescription` (Optional):
    - Capture photo prescription and scan electronic prescription. See [IAPrescriptionScannerScreen](.IAPrescriptionScannerScreen.md).
  - `IACardLink` (Optional):
    - Scan physical electronic health cards. See [IAPrescriptionScannerScreen](.IAPrescriptionScannerScreen.md).
  - `IAOrdering` (Optional):
    - Upload prescriptions to the cart automatically.

## Signature
```swift
public init()
```

## Example

`IARedeemPrescriptionScreen` inside a SwiftUI TabView.

```swift
import IACore
...
TabView {
    IARedeemPrescriptionScreen()
        .tabItem { Text("Home") }
}
```
> [!NOTE]
> Read [Presentation](./../Presentation.md) in order to understand how IA SDK screens can be presented in your app.  
