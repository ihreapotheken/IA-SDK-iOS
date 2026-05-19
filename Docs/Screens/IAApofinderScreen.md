# IAApofinderScreen

A screen that allows users to select a pharmacy by:
- Searching and filtering pharmacies (list and map view)
- Scanning pharmacy code (coming soon)

## Overview
- Module: `IAIntegrations`
- Dependencies:
  - None

## Signature
```swift
public init(isCancellable: Bool, onFinish: @escaping Callback<Pharmacy?>)
```

**Parameters**
  - **isCancellable**: When `false`, users cannot dismiss or go back — they must select a pharmacy. When `true`, a dismiss/back button is shown.
  - **onFinish**: Called when the user selects a pharmacy or dismisses the screen. The `Pharmacy` value is `nil` if the user dismissed without selecting.

## Example
```swift
import IACore

IAApofinderScreen(isCancellable: true, onFinish: { pharmacy in
    // The host app is responsible for dismissing the screen and handling the result.
    // In this example, we switch to the start tab after a pharmacy is selected.
    viewModel.activeSheetTag = nil
    if pharmacy != nil {
        show(tab: .start)
    }
})
.hostEmbedStyle(.presentation(onDismiss: { }))
```

> [!NOTE]
> Read [Presentation](./../Presentation.md) in order to understand how IA SDK screens can be presented in your app.  
