# IAPharmacy

This module contains following features:
* **Pharmacy details screen**: Displays detailed information about the currently selected pharmacy.
    
## IAPharmacyScreen

* `IAPharmacyScreen` shows detailed information about the current pharmacy. 
* It is exposed by `IACore` module but you have to register `.pharmacy` to use it. 
* It uses the pharmacy identifier from the prerequisites flow.
    
### Example

`IAPharmacyScreen` inside a SwiftUI TabView.

```swift
import IACore

TabView {
    IAPharmacyScreen()
        .tabItem { Text("Pharmacy") }
}

```
> [!NOTE]
> Read [Presentation](./Presentation.md) in order to understand how IA SDK screens can be presented in your app.  

## Interaction with other products

**IAPharmacyScreen** is used by:
* **IAOrdering**: 
  * On the cart screen, users can tap on the pharmacy bar at the top, this will open the pharmacy details screen.
* **IAIntegrations**: 
  * On the start screen, users can tap on the pharmacy header, this will open the pharmacy details screen.

