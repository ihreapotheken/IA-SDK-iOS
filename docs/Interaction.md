# SDK Interaction

IA SDK allows the host app to receive events and override default behaviors using the delegate. You can set the delegate like this:
```
IASDK.setDelegate(sdkDelegate)      
```
> [!TIP]
> It is best to set delegates immediately after you call *register* function. So you don't miss any events.


## Example of receiving SDK event
SDKDelegate calls *orderingDidUpdateCart* when cart is updated.
```
final class ExampleIASDKDelegate: SDKDelegate {
    func orderingDidUpdateCart(cartState: IACartState) {
        print(cartState.cartDetails?.totalAmountInCart)
    }
}
```

> [!NOTE]
> This is just an example, inspect the delegates to see what other events are being sent.

## Example of overriding default behavior
SDKDelegate calls *sdkWillNavigateToTarget* when some overidable action is performed.
On example of cart screen, if you don’t implement this method, the default behavior is for the SDK to present the cart screen modally over the current screen.

This behavior is fine in most cases, but if, for example, your app already includes a cart screen embedded inside a tab view, you can override this callback to switch to the cart tab instead of showing a new screen.

```
final class ExampleIASDKDelegate: SDKDelegate {
    // We will switch to cart tab in our example app.
    func sdkWillNavigateToTarget(_ navigationTarget: IANavigationTarget, decisionHandler: @escaping (HandlingDecision) -> Void) {
        switch navigationTarget {
        case .cart: 
            // Use this to set cart in your app, e.g.:
            // viewModel?.selectedTab = .cart
            decisionHandler(.handled)
        default:
            decisionHandler(.performDefault)
        }
    }
}
```

> [!NOTE]
> This is just an example, inspect the delegates to see what else can be overriden.
