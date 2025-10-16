# IAIntegrations

This module contains following features:
* **Prerequisites**: Explained [here](./Prerequisites.md) in more details.
* **Start screen**: Serves as home screen for major IhreApotheken features. Users can:
  * Search and filter products ([IAOverTheCounter](./IAOverTheCounter.md)) 
  * Scan prescriptions ([IAPrescription](./IAPrescription.md)) 
  * Open the cart ([IAOrdering](./IAOrdering.md)) 
  * Open pharmacy details ([IAPharmacy](./IAPharmacy.md)) 
  * See product recommendations ([IAOverTheCounter](./IAOverTheCounter.md))
 
## IAStartScreen

* The `IAStartScreen` acts as the central hub for the IhreApotheken experience, giving users quick access to key features like product search, prescription scanning, and cart management.
* It uses pharmacy identifier from prerequisites flow.

### Example

`IAStartScreen` inside a SwiftUI TabView.

```javascript
TabView {   
    IAStartScreen()
        .tabItem { Text("Home") }
}
```
> [!NOTE]
> Read [Presentation](./Presentation.md) in order to understand how IA SDK screens can be presented in your app.  

## Interaction with other products

**IAIntegrations** is used by:
* **IASDK**: `IASDK.initialize` method starts the Prerequisites flow.

