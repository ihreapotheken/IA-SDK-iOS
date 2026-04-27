# IAOrdering

This module provides features for cart management, checkout, payment processing, and the thank you page.

* **Empty cart screen:** When the cart is empty it shows recommended products and products of the month. It allows users to add products and prescriptions.
    
* **Cart screen:** Overview of all products and prescriptions in the cart, including cost section.
    
* **Checkout screen:** Delivery and payment options, product overview, prescription overview, and the cost section.
    
* **PayPal payment:** In-app PayPal integration.
    
* **Thank You screen:** Overview of the order, users can provide their own thank you screen (not yet available).

## IACartScreen

* The `IACartScreen` provides a complete, self-managed flow for cart, checkout, and payment. The screen is reactive and integrates seamlessly with other modules—when a product is added to the cart elsewhere in the app, the cart screen automatically reflects the update.
* It is exposed by `IACore` module but you have to register `.ordering` to use it. 
* It uses pharmacy identifier from prerequisites flow.

  
### Example

`IACartScreen` inside a SwiftUI TabView.

```swift
import IACore
...
TabView {
    IACartScreen()
        .tabItem { Text("Cart") }
}

```

> [!NOTE]
> Read [Presentation](./Presentation.md) in order to understand how IA SDK screens can be presented in your app.  

## IACartButton

* `IACartButton` is a UI component that displays a cart icon with the current item count, typically placed in a navigation bar or toolbar.
* It is exposed by `IACore` module but you have to register `.ordering` to use it.
* By default, tapping the button presents the cart screen automatically and sends `SDKDelegate.sdkWillNavigateToTarget`.
* Optionally, an `onTap` callback can be provided — in that case the host app is fully responsible for handling the tap and the cart is not opened automatically.

> [!IMPORTANT]
> SDK initialization and prerequisites (pharmacy selection) must be completed before using this component. You can run it manually or set `IASDK.configuration.isAutoInitializationEnabled` and it will be automatically perfomed as soon as `IACartButton` is added to the view hierarchy. To learn more about initialization, see [Initialization](Initialization.md).


https://github.com/user-attachments/assets/787f1702-af05-4550-94cf-7807382d1998


### Example

`IACartButton` with default behaviour — cart opens automatically on tap.

```swift
import IACore

IACartButton()
```

`IACartButton` with a custom tap handler.

```swift
import IACore

IACartButton {
    // host app handles tap
}
```

> [!NOTE]
> See [IACartButtonExamples](../Examples/MainExample/MainExample/Components/IACartButtonExamples) for a complete example.

## Interaction with other products

**IAOrdering** is used by:
* **IAOverTheCounter**: 
  * Products can be added to cart from the products search screen and the product details screen. 
  * Product search screen shows the cart button.
* **IAPrescription**: 
  * Automatically adds prescriptions to cart after scanning is finished.
* **IACardLink**: 
  * Automatically adds prescriptions to cart after scanning is finished.
* **IAPharmacy**: 
  * Pharmacy details screen shows the cart icon.
* **IAIntegrations**:
  * Start screen shows the cart icon.
 
## Public API
Deletes cart from internal storage.
- `deleteCart()`

Returns current cart.
- `getCartDetails(allowCached:throwIfNil:shouldEmit:)`

Uploads prescriptions and adds them to the cart.
- `transferPrescriptions(images:pdfs:codes:orderID:showActivityIndicator:finishAction:)`

Returns a publisher that emits cart state updates.
- `cartStateNotifier(_ type:)`

  
