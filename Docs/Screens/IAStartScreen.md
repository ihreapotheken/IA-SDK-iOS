# IAStartScreen

Acts as the central hub for the IhreApotheken experience, giving users quick access to key features like product search, prescription scanning, and cart management.

## Overview
- Module: `IAIntegrations`
- Dependencies:
  - Pharmacy Identifier: from the prerequisites flow.
  - `IAPharmacy` (Optional): Tapping pharmacy header opens the pharmacy details screen.
  - `IAOverTheCounter`: Integreated search bar.
  - `IAOrdering` (Optional): Displays a cart button for navigating to the checkout flow.
  - `IAPrescription` (Optional): Ability to add prescriptions and electronic prescriptions directly from the start screen.
  - `IACardLink` (Optional): Ability to scan physical electorinic cards directly from the start screen.

## Signature
```swift
public init()
```

## Example

`IAStartScreen` inside a SwiftUI TabView.

```swift
import IAIntegrations
...
TabView {
    IAStartScreen()
        .tabItem { Text("Home") }
}
```
> [!NOTE]
> Read [Presentation](./../Presentation.md) in order to understand how IA SDK screens can be presented in your app.  
