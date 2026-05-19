# IACartButton

* `IACartButton` is a UI component that displays a cart icon with the current item count, typically placed in a navigation bar or toolbar.
* By default, tapping the button presents the cart screen automatically and sends `SDKDelegate.sdkWillNavigateToTarget`.
* Optionally, an `onTap` callback can be provided — in that case the host app is fully responsible for handling the tap and the cart is not opened automatically.

> [!IMPORTANT]
> SDK initialization and prerequisites (pharmacy selection) must be completed before using this component. You can run it manually or set `IASDK.configuration.isAutoInitializationEnabled` and it will be automatically perfomed as soon as `IACartButton` is added to the view hierarchy. To learn more about initialization, see [Initialization](Initialization.md).


https://github.com/user-attachments/assets/787f1702-af05-4550-94cf-7807382d1998

## Overview
- Module: `IAOrdering`
- Dependencies:
  - None

## Example

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
> See [IACartButtonExamples](../../Examples/MainExample/MainExample/Components/IACartButtonExamples) for a complete example.
