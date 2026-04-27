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
* You can use `shouldShowLoading` parameter to control whether you want to hide grid while loading or show shimmer animation.
* If there is no product to show it will return empty view, you can use `hasContent` binding to determine if it has content.
> [!CAUTION] 
> Do NOT use `hasContent` property to show/hide `IAProductGrid` because hiding and showing will destroy its state and will make it reload again. Use `hasContent` property only to adjust padding or other style/layout properties if you need to.

> [!IMPORTANT]
> SDK initialization and prerequisites (pharmacy selection) must be completed before using this component. You can run it manually or set `IASDK.configuration.isAutoInitializationEnabled` and it will be automatically perfomed as soon as `IAProductGrid` is added to the view hierarchy. To learn more about initialization, see [Initialization](Initialization.md).

https://github.com/user-attachments/assets/f0a33e8e-a4ec-406b-a793-053d9732d386

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

> [!NOTE]
> See [IAProductGridExamples](../Examples/MainExample/MainExample/Components/IAProductGridExamples) for a complete example.

## Interaction with other products

**IAOverTheCounter** is used by:
* **IAOrdering**: 
  * Shows recommended products on cart and thank you screens. 
  * Users can start the search process from the cart screen.
* **IAIntegrations**: 
  * Shows recommended products on the start screen.
  * Users can start the search process from the start screen. 

