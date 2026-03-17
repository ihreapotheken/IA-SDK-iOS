# Appearance

Make sure you make any adjustments to the UI **before** running the `Prerequisites` or showing any Screens from this SDK.

## Liquid Glass

IA SDKs support Liquid Glass, starting from iOS 26.0.

To enable it, make sure you set `UIDesignRequiresCompatibility` to `false` in your `Info.plist`. Then, before using any of IA SDK provided UI components, make sure you edit your configuration like so:

```swift
IASDK.configuration.uiConfiguration.supportsLiquidGlass = true
```

**Note**: If you do not set `supportsLiquidGlass` to `true`, there will be some visual artifacts. 

## Bouncy ScrollViews

IA SDKs use SwiftUI's ScrollViews which have `bounces` enabled by default. If you wish to disable the native bouncing of ScrollViews, use the following code bfore using any of IA SDKs Screens:

```swift
UIScrollView.appearance().bounces = false
````

**Note**: This method is not recommended as it will disable bouncing for all ScrollViews inside your app which might be unwanted behaviour.

## Navigation Bar Appearance

The Navigation Bar used throughout SDKs generates colors based on the Primary Color set on BEP. You can override these colors using the UI Configuration like so:
```swift
IASDK.configuration.uiConfiguration.header.primaryColor = .blue
IASDK.configuration.uiConfiguration.header.secondaryColor = .green
```
The secondary Color corresponds to the Color of the custom graphic in the background of the Navigation Bar. You can remove the custom graphic by doing the following:
```swift
IASDK.configuration.uiConfiguration.header.style = .monotone // default is duotone
```

## Primary & Secondary Buttons Appearance

You can adjust the appearance of Primary and Secondary Buttons by setting custom background, text and border colors, border radii and border width as well as customize their appeareance when they are disabled. Here is an example on how you can adjust the appearance of the Primary Button:

```swift
IASDK.configuration.uiConfiguration.primaryButton.backgroundColor = .init(rgb: 0x990000)
IASDK.configuration.uiConfiguration.primaryButton.backgroundDisabledColor = .gray
IASDK.configuration.uiConfiguration.primaryButton.textColor = .init(rgb: 0xEEEEEE)
IASDK.configuration.uiConfiguration.primaryButton.textDisabledColor = .black
IASDK.configuration.uiConfiguration.primaryButton.borderColor = .init(rgb: 0xBBBBBB)
IASDK.configuration.uiConfiguration.primaryButton.borderDisabledColor = .black
IASDK.configuration.uiConfiguration.primaryButton.borderWidth = 4
IASDK.configuration.uiConfiguration.primaryButton.borderRadius = 0
```

The Secondary button has the same properties as the Primary Button. To adjust its appearance, just replace `primaryButton` with `secondaryButton` in the code above.