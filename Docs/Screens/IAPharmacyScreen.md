# IAPharmacyScreen

Displays detailed information about the currently selected pharmacy.

## Overview
- Module: `IAPharmacy`
- Dependencies:
  - Pharmacy Identifier: from the prerequisites flow.
  - `IAOrdering`: 
    - Cart button for navigating to the checkout flow.
  - `IAIntegrations`: 
    - Apofinder
    - Appointment Booking

## Signature
```swift
public init()
```

## Example

`IAPharmacyScreen` inside a SwiftUI TabView.

```swift
import IACore

TabView {
    IAPharmacyScreen()
        .tabItem { Text("Pharmacy") }
}
```

> [!NOTE]
> Read [Presentation](./../Presentation.md) in order to understand how IA SDK screens can be presented in your app.  
