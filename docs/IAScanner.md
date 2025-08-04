# IAScanner

This module contains following features:
* **Scanner screen**: Lets users upload a photo of a prescription or scan an electronic prescription to add it to the cart.

## IAScannerScreen

* The `IAScannerScreen` provides a streamlined interface for submitting prescriptions. 
* It supports two input methods: users can either capture a photo of a physical prescription (or select one from their gallery), or scan an electronic prescription (E-Prescription).
* The prescription is automatically added to the cart for processing.
    
### Example

`IAScannerScreen` inside a SwiftUI TabView.

```javascript
TabView {   
    IAScannerScreen()
        .tabItem { Text("Scanner") }
}
```
> [!NOTE]
> Read [Presentation](./Presentation.md) in order to understand how IA SDK screens can be presented in your app.  

## Interaction with other products

**IAScanner** is used by:
* **IAOrdering**: 
  * Scanning process can be started from the cart screen.
* **IAIntegrations**: 
  * Scanning process can be started from the start screen.
* **IAOverTheCounter**: 
  *Scanning process can be started from the product details screen.

