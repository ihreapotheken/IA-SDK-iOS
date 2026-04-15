# IAOverTheCounter

This module provides features related to search and products.

* **Search screen**: Search bar with list of products, allows filtering and sorting.

* **Product details**: Displays details of a selected product.

* **Product inquiry**: Enables the user to send an email to pharmacies and inquire about the product.

* **Cart integration**: The cart is integrated into the list and details if the `IAOrdering` module is set up.
    

## IAProductSearchScreen

* `IAProductSearchScreen` handles searching, filtering, and displaying detailed product information, all in one seamless flow.
* It is exposed by `IACore` module but you have to register `.overTheCounter` to use it. 
* Allows users to send inquiries to pharmacies about the product.
* It uses pharmacy identifier from prerequisites flow.
    
### Example

`IAProductSearchScreen` inside a SwiftUI TabView.

```swift
import IACore
...
TabView {
    IAProductSearchScreen()
        .tabItem { Text("Search") }
}

```
> [!NOTE]
> Read [Presentation](./Presentation.md) in order to understand how IA SDK screens can be presented in your app.  

## IAProductGrid

* `IAProductGrid` is a UI component that embeds a grid of pharmacy products directly into your layout.
* It is exposed by `IACore` module but you have to register `.overTheCounter` to use it.
* Supports multiple product types: current offers, products of the month, product recommendations, customers also bought, and custom PZN lists.
* Tapping a product opens product details. If `IAOrdering` is set up, users can add products to the cart.

> [!IMPORTANT]
> SDK initialization and prerequisites (pharmacy selection) must be completed before using this component.

<video src="resources/ia_product_grid_example.mp4" controls></video>

### Example

`IAProductGrid` embedded in a host app screen, without navigation.

```swift
import IACore

IAProductGrid(type: .currentOffers())
```

`IAProductGrid` with navigation, so connected screens are pushed instead of presented modally.

```swift
import IACore

UIKitNavigationView(shouldUpdateRootView: true) { navigator in
    IAProductGrid(type: .currentOffers(), navigator: navigator)
}
```

## Interaction with other products

**IAOverTheCounter** is used by:
* **IAOrdering**: 
  * Shows recommended products on cart and thank you screens. 
  * Users can start the search process from the cart screen.
* **IAIntegrations**: 
  * Shows recommended products on the start screen.
  * Users can start the search process from the start screen. 

