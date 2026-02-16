# Appearance

## Liquid Glass

IA SDKs support Liquid Glass, starting from iOS 26.0.

To enable it, make sure you set `UIDesignRequiresCompatibility` to `false` in your `Info.plist`. Then, before using any of IA SDK provided UI components, make sure you edit your configuration like so:

```swift
IASDK.configuration.supportsLiquidGlass = true
```

**Note**: If you do not set `supportsLiquidGlass` to `true`, there will be some visual artifacts. 

## Bouncy ScrollViews

IA SDKs use SwiftUI's ScrollViews which have `bounces` enabled by default. If you wish to disable the native bouncing of ScrollViews, use the following code bfore using any of IA SDKs Screens:

```swift
UIScrollView.appearance().bounces = false
````

**Note**: This method is not recommended as it will disable bouncing for all ScrollViews inside your app which might be unwanted behaviour.