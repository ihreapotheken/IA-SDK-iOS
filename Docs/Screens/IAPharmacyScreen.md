# IAPharmacyScreen

Shows detailed information about the current pharmacy. 

## Overview
- Module: `IAPharmacy`
- Dependencies:
  - pharmacy identifier: from the prerequisites flow.


## Signature
```swift
public init() {}
```

> [!NOTE]
> Read [Presentation](./../Presentation.md) in order to understand how IA SDK screens can be presented in your app.  

## Example

`IAPharmacyScreen` inside a SwiftUI TabView.

```swift
import IACore

TabView {
    IAPharmacyScreen()
        .tabItem { Text("Pharmacy") }
}
