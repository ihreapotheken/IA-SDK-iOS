# IAOverTheCounter

This module provides features related to search and products.

* **Search screen**: Search bar with list of products, allows filtering and sorting.

* **Product details**: Displays details of a selected product.

* **Product inquiry**: Enables the user to send an email to pharmacies and inquire about the product.

* **Cart integration**: The cart is integrated into the list and details if the `IAOrdering` module is set up.
    

## IAProductSearchScreen

* `IAProductSearchScreen` handles searching, filtering, and displaying detailed product information, all in one seamless flow.
* It is exposed by `IACore` module but you have to register `.overTheCounter` to use it. 
* Allows users to send inquiries to pharmacies about the product.
* It uses pharmacy identifier from prerequisites flow.
    
### Example

`IAProductSearchScreen` inside a SwiftUI TabView.

```swift
import IACore
...
TabView {
    IAProductSearchScreen()
        .tabItem { Text("Search") }
}

```
> [!NOTE]
> Read [Presentation](./Presentation.md) in order to understand how IA SDK screens can be presented in your app.  

## Interaction with other products

**IAOverTheCounter** is used by:
* **IAOrdering**: 
  * Shows recommended products on cart and thank you screens. 
  * Users can start the search process from the cart screen.
* **IAIntegrations**: 
  * Shows recommended products on the start screen.
  * Users can start the search process from the start screen. 

