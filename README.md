IA SDK is iOS SDK that helps integrate IhreApotheken into your app by providing plug-and-play UI and communication with backend services.

The SDK consists of the following modules:
* **IAIntegrations**: Legal, onboarding, start screen, Apofinder (pharmacy search with list and map).
* **IAOverTheCounter**: Product search, product details, inquiry.
* **IAOrdering**: Cart, checkout, payment.
* **IAPharmacy**: Pharmacy details.
* **IAPrescription**: Prescription scanner.
* **IACardLink**: Scanning prescriptions from electornic health cards.

To use IA SDK, you will need an API key and Client ID. The API key is bound to specific app Bundle ID(s) and comes with a set of entitlements. Each entitlement enables access to certain features or services within the SDK.

IA SDK is developed in Swift/SwiftUI.

# Requirements

* iOS 15 or above
* API key
* Client ID


# Installation

To add the IA SDK to your Xcode project, follow these steps:

1.  Open your Xcode `project` or `workspace`, then go to **File > Add Package Dependencies**…
    
2.  In the **Search or Enter Package URL** field, enter [https://github.com/ihreapotheken/IA-SDK-iOS](https://github.com/ihreapotheken/IA-SDK-iOS).
    
3.  Specify the version you want to use and click **Add Package**. We recommend selecting **Exact Version** at this time.  
    ![](Docs/resources/installation_1.png)

4.  Choose the package products you need, assign them to your app target, and click **Add Package**.

    > ⚠️ You need to select only package products that you will use and for which your API key has entitlements.

    ![](Docs/resources/installation_2.png)

# Project setup
1. If you are using apofinder then you need to add **NSLocationWhenInUseUsageDescription** key to your Info.plist.
2. If you are using CardLink then please read [IACardlink](./Docs/IACardLink.md)

# Usage
1. **Set bundle identifier**  
You need to set your bundle identifier in the target’s Build Settings, as the API key is linked specifically to that identifier.

2. **Import the required products**  
In order to use the modules you have to import them. `IACore` and `IAIntegrations` are mandatory, others are optional. In this example we will be using product search from `IAOverTheCounter` and cart from `IAOrdering`.
```swift
import IACore
import IAIntegrations
import IAOverTheCounter
import IAOrdering
```

3. **Register modules and basic setup**  
The first step is to register all the modules you plan to use. This must be done before calling any functions or presenting any screens.  The registration function is synchronous, so we recommend running it immediately when the app starts.
This step is required because products can be interconnected. For example, registering `ordering` makes the **Cart** feature (from `IAOrdering`) internally available to the **Product Search** feature (from `IAOverTheCounter`), enabling features like a cart button on the search screen.
```swift    
IASDK.register([
    .integrations, 
    .overTheCounter,
    .ordering,
    .apofinder
])
```
> [!IMPORTANT]
> Make sure to call register before anything else.

4. **Basic setup**  
Next, you need to enter you API key, client ID and other things you might need. We suggest doing this right after you call register.
```swift
IASDK.configuration.apiKey = "ENTER YOUR API KEY HERE"
IASDK.configuration.clientID = "ENTER YOUR CLIENT ID HERE"
IASDK.setEnvironment(.staging)
IASDK.Pharmacy.savePharmacyID(2163)     // If you have pharmacy ID, you can set it before you call initialize, otherwise initialize will show Apofinder (if enabled).
IASDK.setDelegate(sdkDelegate)          // If you use delegate, 
```

5. **Initialize**  
Before using any SDK features, you must ensure that required conditions are met. Call the `initialize` function once your UI is ready. This will fetch all required data and enable your modules for running.
```
let prerequisitesOptions = IASDKPrerequisitesOptions(
    isCancellable: false, 
    isAnimated: true,
    shouldRunLegal: true,
    shouldRunOnboarding: true, 
    shouldRunApofinder: true
)
let result = try await IASDK.initialize(shouldShowIndicator: true, prerequisitesOptions: prerequisitesOptions)
navigationPath.append(.iaStartScreen)
```
> [!TIP]
> To learn more about initialization, see [Initialization](./Docs/Initialization.md).

# Features
[All modules and features](./Docs/FeatureOverview.md)
[Initialization](./Docs/Initialization.md)
[IAIntegrations](./Docs/IAIntegrations.md)
[IAOverTheCounter](./Docs/IAOverTheCounter.md)
[IAOrdering](./Docs/IAOrdering.md)
[IAPharmacy](./Docs/IAPharmacy.md)
[IAPrescription](./Docs/IAPrescription.md)
[IACardlink](./Docs/IACardLink.md)
[Presentation](./Docs/Presentation.md)
[Appearance](./Docs/Appearance.md)
[SDK Interaction](./Docs/Interaction.md)
[Error Codes](./Docs/IAErrorCodes.md)

# Full example code
This is full code for example app that has product search on one tab and cart on another. These two features will internally communicate, e.g. when you add some product from search or any other screen, it will be added to cart.

```swift
import SwiftUI
import Combine
import IACore
import IAIntegrations
import IAOverTheCounter
import IAOrdering
import IAPrescription

@main
struct MainExampleApp: App {
    @StateObject private var viewModel = ExampleAppViewModel2()
    
    var body: some Scene {
        WindowGroup {
            if viewModel.isLoaded {
                TabView {   
                    IAProductSearchScreen()
                        .tabItem { Text("Search") }
                    
                    IACartScreen()
                        .tabItem { Text("Cart") }
                }
            } else {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

@MainActor
final class ExampleAppViewModel2: ObservableObject {
    @Published var isLoaded = false
    @Published var errorMessage: String?
    
    init() {
        IASDK.register([
            .integrations, 
            .overTheCounter,
            .ordering,
            .apofinder,
            .prescription
        ])

        IASDK.configuration.apiKey = "ENTER YOUR API KEY HERE"
        IASDK.configuration.clientID = "ENTER YOUR CLIENT ID HERE"
        IASDK.setEnvironment(.staging)

        Task {
            await initializeSDK()
        }
    }
    
    func initializeSDK() async {
        do {
            let prerequisitesOptions = IASDKPrerequisitesOptions(
                isCancellable: false, 
                isAnimated: true, 
                shouldRunLegal: true, 
                shouldRunOnboarding: true, 
                shouldRunApofinder: true
            )
            
            let result = try await IASDK.initialize(shouldShowIndicator: true, prerequisitesOptions: prerequisitesOptions)
            isLoaded = true // We don't have to check result because isCancellable is false, otherwise you need to check result.didAgreeToLegalNotice and result.pharmacyID
        } catch {
            errorMessage = "Error\n\(error)"
        }
    }
}
```

# Usage and Testing FAQ

For information on server environments, testing credentials, access requirements, and bug reporting guidelines, 
see the [Usage and Testing documentation](https://ihreapotheken.github.io/docs/appsdk/common/usage-and-testing).
