## DemoUIKitExample

DemoUIKitExample is an UIKit application that showcases how to integrate IhreApotheken IA SDK modules inside a classic UITabBarController setup.

Initialization: UIKitExampleViewModel configures the IA SDK (API key, client ID, module registration) and runs IASDK.initialize.

Core setup: the app embeds IA SDK screens such as IAStartScreen, IACartScreen, and IAScannerScreen.

State handling: TabBarController listens to the initialization state and presents either the tab bar or an error overlay via SwiftUI views hosted with `UIHostingController`.

Use it as a reference when wiring IA SDK into existing UIKit projects without switching fully to SwiftUI.
