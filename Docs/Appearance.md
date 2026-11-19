# Appearance

Make sure you make any adjustments to the UI **before** running the `Prerequisites` or showing any Screens from this SDK.

## Liquid Glass

IA SDKs support Liquid Glass, starting from iOS 26.0, and use it by default.

If your app runs in compatibility mode (`UIDesignRequiresCompatibility` set to `true` in your `Info.plist`, see [Liquid Glass](iOSProjectSetup.md#4-liquid-glass) in the iOS Project Setup guide), then before using any of IA SDK provided UI components, make sure you edit your configuration like so:

```swift
IASDK.configuration.uiConfiguration.supportsLiquidGlass = false
```

**Note**: If your app runs in compatibility mode and you do not set `supportsLiquidGlass` to `false`, there will be some visual artifacts. Once you build with Xcode 27 or later, remove `UIDesignRequiresCompatibility` from your `Info.plist` and keep `supportsLiquidGlass` at its default value `true`, because iOS 27 ignores the key for those apps and always uses Liquid Glass.

## Bouncy ScrollViews

IA SDKs use SwiftUI's ScrollViews which have `bounces` enabled by default. If you wish to disable the native bouncing of ScrollViews, use the following code before using any of IA SDKs Screens:

```swift
UIScrollView.appearance().bounces = false
```

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