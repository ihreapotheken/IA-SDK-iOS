# SDK Interaction

IA SDK allows the host app to receive events and override default behaviors using the delegates. You can set the delegates like this:
```
IASDK.setDelegates(
    sdk: sdkDelegate,
    ordering: orderingDelegate,
    prescription: prescriptionDelegate,
    cardLink: cardLinkDelegate
)      
```
Or if all your delegates are one object then you can use convenience:
```
IASDK.setSingleDelegate(delegate)
```
> [!TIP]
> It is best to set delegates immediately after you call *register* function. So you don't miss any events.


Following delegates are available:
- SDKDelegate
- OrderingDelegate
- PrescriptionDelegate
- CardLinkDelegate

## Example of receiving SDK event
SDKDelegate calls *hostAppShouldOpenPrivacyPolicy* when privacy button is tapped in the footer, you can implement that function and present your privacy policy.
```
final class ExampleIASDKDelegate: SDKDelegate {
    func hostAppShouldOpenPrivacyPolicy() {
        // Present your privacy policy
    }
}
```

> [!NOTE]
> This is just an example, inspect the delegates to see what other events are being sent.

## Example of overriding default behavior
SDKDelegate calls *cartButtonWillOpenCartScreen* when the cart button is tapped in any SDK screen.
If you don’t implement this method, the default behavior is for the SDK to present the cart screen modally over the current screen.

This behavior is fine in most cases, but if, for example, your app already includes a cart screen embedded inside a tab view, you can override this callback to switch to the cart tab instead of showing a new screen.

```
final class ExampleIASDKDelegate: SDKDelegate {
    // We will switch to cart tab in our example app.
    func cartButtonWillOpenCartScreen() -> HandlingDecision {
        viewModel?.selectedTab = .cart
        return .handled
    }
}
```

> [!NOTE]
> This is just an example, inspect the delegates to see what else can be overriden.
