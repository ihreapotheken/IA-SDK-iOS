# IAOrdering

This module contains following features:
- [IACartScreen](Screens/IACartScreen.md)
- [IACartButton](Components/IACartButton.md)

## Public API
Deletes cart from internal storage.
- `deleteCart()`

Returns current cart.
- `getCartDetails(allowCached:throwIfNil:shouldEmit:)`

Uploads prescriptions and adds them to the cart.
- `transferPrescriptions(images:pdfs:codes:orderID:showActivityIndicator:finishAction:)`

Returns a publisher that emits cart state updates.
- `cartStateNotifier(_ type:)`