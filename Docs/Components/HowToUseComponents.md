# How to use components

IA SDK components (e.g. `IAProductGrid`) can be embedded anywhere in your app's UI. Like every IA SDK screen, they require:
* **SDK initialization** to be finished.
* **Prerequisites** (e.g. pharmacy selection) to be completed.

Until both are done, a component shows only a loading indicator.

This is easy to handle if you call `IASDK.initialize` with `prerequisitesOptions` before any component is shown, e.g. when your app starts.

It gets trickier when a component can be shown before you call `IASDK.initialize`, for example:

> Your app has a single SDK entry point on the third tab, where you call `IASDK.initialize`. Now you want to add `IAProductGrid` to the first tab, which the user sees first.

This guide shows how to handle initialization and prerequisites in such cases.

> [!TIP]
> To learn more about initialization and prerequisites in general, see [Initialization](../Initialization.md).

## Initialization

Choose one of the following options.

### Option 1: Call `initialize` in every place that uses the SDK
Call `IASDK.initialize` both in your SDK entry point and before showing the component. This is safe because `initialize` is idempotent:
* SDK initialization runs only once, no matter how many times you call `initialize`.
* The prerequisites flow presents screens only when needed (first time, or when something changed, e.g. a new version of legal documents).

```swift
let prerequisitesOptions = IASDKPrerequisitesOptions(
    isCancellable: false,
    isAnimated: true,
    shouldRunLegal: true,
    shouldRunOnboarding: true,
    shouldRunApofinder: true
)
let _ = try await IASDK.initialize(shouldShowIndicator: true, prerequisitesOptions: prerequisitesOptions)
// Show IAProductGrid
```

### Option 2: Call `initialize` once at app start
Call `IASDK.initialize` with `prerequisitesOptions` once when your app starts. After that, components and screens can be used anywhere in the app.

> [!NOTE]
> This presents prerequisites screens at app start (only if needed). If you don't want that, see [Prerequisites](#prerequisites) below.

### Option 3: Automatic initialization
Enable automatic initialization. The component then initializes the SDK and runs prerequisites by itself when it appears, using `defaultInitializationOptions`.

```swift
IASDK.configuration.isAutoInitializationEnabled = true
IASDK.configuration.defaultInitializationOptions = .init(
    shouldShowIndicator: false,
    prerequisitesOptions: .init(
        isCancellable: false,
        isAnimated: true,
        shouldRunLegal: true,
        shouldRunOnboarding: true,
        shouldRunApofinder: true
    )
)
```

> [!NOTE]
> With automatic initialization, prerequisites screens are presented as soon as the component appears (only if needed). If you don't want that, see [Prerequisites](#prerequisites) below.

## Prerequisites

You might not want prerequisites screens (e.g. onboarding) to appear where the component is shown, e.g. on the first tab. Instead, you might want to show the component only if the user has already completed prerequisites in your SDK entry point.

### Check if prerequisites are completed
Use `IASDK.Prerequisites.prerequisitesCompletionStatus(runOnboardingIfNeeded:runLegalIfNeeded:)` and show the component only if `areAllCompleted` is `true`.
* Pass the same values you use for `shouldRunOnboarding` and `shouldRunLegal` in your SDK entry point. The pharmacy is always checked.
* It throws `IASDKError.sdkNotInitialized` if the SDK is not initialized. Initialize first, **without** `prerequisitesOptions`, so that no prerequisites screens are presented.

```swift
let _ = try await IASDK.initialize(shouldShowIndicator: false, prerequisitesOptions: nil)
let status = try await IASDK.Prerequisites.prerequisitesCompletionStatus(
    runOnboardingIfNeeded: true,
    runLegalIfNeeded: true
)
if status.areAllCompleted {
    // Show IAProductGrid
}
```

### Show the component as soon as prerequisites are completed (optional)
`prerequisitesCompletionStatus` returns the state at the moment you call it. If the user completes prerequisites later (e.g. in your SDK entry point on the third tab), you can observe `IASDK.initializationStatePublisher` and show the component as soon as `summary` becomes `.initializationAndPrerequisitesFinished`.

> [!CAUTION]
> Use this check only to decide whether to add the component to your layout. Don't use it to hide and show the component repeatedly, as that destroys its state and makes it reload.
