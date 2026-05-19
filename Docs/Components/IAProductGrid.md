# IAProductGrid

* `IAProductGrid` is a UI component that embeds a grid of pharmacy products directly into your layout.
* Supports multiple product types: current offers, products of the month, product recommendations, customers also bought, and custom PZN lists.
* Tapping a product opens product details. If `IAOrdering` is set up, users can add products to the cart.
* You can use `shouldShowLoading` parameter to control whether you want to hide grid while loading or show shimmer animation.
* If there is no product to show it will return empty view, you can use `hasContent` binding to determine if it has content.
> [!CAUTION] 
> Do NOT use `hasContent` property to show/hide `IAProductGrid` because hiding and showing will destroy its state and will make it reload again. Use `hasContent` property only to adjust padding or other style/layout properties if you need to.

> [!IMPORTANT]
> SDK initialization and prerequisites (pharmacy selection) must be completed before using this component. You can run it manually or set `IASDK.configuration.isAutoInitializationEnabled` and it will be automatically perfomed as soon as `IAProductGrid` is added to the view hierarchy. To learn more about initialization, see [Initialization](Initialization.md).

https://github.com/user-attachments/assets/f0a33e8e-a4ec-406b-a793-053d9732d386


## Overview
- Module: `IAOrdering`
- Dependencies:
  - `IAOrdering` (Optional):
    - Add product to the cart.

## Example

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
> See [IAProductGridExamples](../../Examples/MainExample/MainExample/Components/IAProductGridExamples) for a complete example.