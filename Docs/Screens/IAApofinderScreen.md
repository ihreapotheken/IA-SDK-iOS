# IAApofinderScreen

A screen that allows users to select a pharmacy.

Supported selection methods:
- Search and filter pharmacies (list and map view)
- Scan pharmacy code (coming soon)

## Basic information
- Implemented in: `IAIntegrations`
- Defined in: `IACore`
- Dependencies:
  - uses pharmacy identifier from the prerequisites flow.

## Definition
```swift
public init(isCancellable: Bool, onFinish: @escaping Callback<Pharmacy?>) {
    self.isCancellable = isCancellable
    self.onFinish = onFinish
}
```

- Parameters:
  - **isCancellable**: When `false`, users cannot dismiss or go back — they must select a pharmacy. When `true`, a dismiss/back button is shown.
  - **onFinish**: Called when the user selects a pharmacy or dismisses the screen. The `Pharmacy` value is `nil` if the user dismissed without selecting.

> [!NOTE]
> Read [Presentation](./Presentation.md) in order to understand how IA SDK screens can be presented in your app.  

## Example
```swift
import IACore

IAApofinderScreen(isCancellable: true, onFinish: { pharmacy in
    viewModel.activeSheetTag = nil
    if pharmacy != nil {
        DIDemoApp.rootAppViewModel.show(tab: .start)
    }
})
.hostEmbedStyle(.presentation(onDismiss: { }))
```