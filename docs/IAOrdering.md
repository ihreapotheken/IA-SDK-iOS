# IAOrdering

This module provides features for cart management, checkout, payment processing, and the thank you page.

* **Empty cart screen:** When the cart is empty it shows recommended products and products of the month. It allows users to add products and prescriptions.
    
* **Cart screen:** Overview of all products and prescriptions in the cart, including cost section.
    
* **Checkout screen:** Delivery and payment options, product overview, prescription overview, and the cost section.
    
* **PayPal payment:** In-app PayPal integration.
    
* **Thank You screen:** Overview of the order, users can provide their own thank you screen (not yet available).
    

## IACartScreen

* The `IACartScreen` is the primary component exposed by the `IAOrdering` module. 
* It provides a complete, self-managed flow for cart, checkout, and payment. The screen is reactive and integrates seamlessly with other modules—when a product is added to the cart elsewhere in the app, the cart screen automatically reflects the update.
* It uses pharmacy identifier from prerequisites flow.
  

### Example

`IACartScreen` inside a SwiftUI TabView.

```javascript
TabView {   
    IACartScreen()
        .tabItem { Text("Cart") }
}

```

> [!NOTE]
> Read [Presentation](./Presentation.md) in order to understand how IA SDK screens can be presented in your app.  

## Interaction with other products

**IAOrdering** is used by:
* **IAOverTheCounter**: 
  * Products can be added to cart from the products search screen and the product details screen. 
  * Product search screen shows the cart button.
* **IAScanner**: 
  * Automatically adds prescriptions to cart after scanning is finished.
* **IACardLink**: 
  * Automatically adds prescriptions to cart after scanning is finished.
* **IAPharmacy**: 
  * Pharmacy details screen shows the cart icon.
* **IAIntegrations**:
  * Start screen shows the cart icon.

  
