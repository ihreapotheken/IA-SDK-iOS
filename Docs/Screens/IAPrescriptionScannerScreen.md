# IAPrescriptionScannerScreen

Provides a streamlined interface for submitting prescriptions. It supports two input methods:
- Capture a photo of a physical prescription (or select one from their gallery)
- Scan an electronic prescription (E-Prescription)
  
The prescription is automatically added to the cart for processing (can be overridden in `SDKDelegate`).

## Overview
- Module: `IAPrescription`
- Dependencies:
  - Pharmacy Identifier: needed for uploading to cart.
  - `IAOrdering` (Optional): 
    - Upload prescriptions to the cart.

## Signature
```swift
public init(type: IAPrescriptionScannerType)
```

**Parameters**
  - **type**: `.prescription` (capture photo) or `.ePrescription` (scan electronic prescription)

## Example
`IAPrescriptionScannerScreen` inside a SwiftUI TabView.

```swift
import IACore
...
TabView {
    IAPrescriptionScannerScreen(type: .prescription)
        .tabItem { Text("Scanner") }
}
```

> [!NOTE]
> Read [Presentation](./../Presentation.md) in order to understand how IA SDK screens can be presented in your app.  
