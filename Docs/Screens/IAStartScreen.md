## IAStartScreen

* The `IAStartScreen` acts as the central hub for the IhreApotheken experience, giving users quick access to key features like product search, prescription scanning, and cart management.
* It is exposed by IACore module but you have to register .integrations to use it. 
* It uses pharmacy identifier from the prerequisites flow.

### Example

`IAStartScreen` inside a SwiftUI TabView.

```swift
import IAIntegrations

TabView {
    IAStartScreen()
        .tabItem { Text("Home") }
}
```
> [!NOTE]
> Read [Presentation](./Presentation.md) in order to understand how IA SDK screens can be presented in your app.  