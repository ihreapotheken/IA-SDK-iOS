# IAApofinderScreen

A screen that allows users to select a pharmacy. Users can select new pharmacy by:
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

> [!NOTE]
> Read [Presentation](./../Presentation.md) in order to understand how IA SDK screens can be presented in your app.  

## Example
```swift
import IACore

IAApofinderScreen(isCancellable: true, onFinish: { pharmacy in
    // Host app is resposible for dismissing the Apofinder screen screen and determening what to do after pharmacy is selected, in this example we are switching to the start tab.
    viewModel.activeSheetTag = nil
    if pharmacy != nil {
        show(tab: .start)
    }
})
.hostEmbedStyle(.presentation(onDismiss: { }))
```
