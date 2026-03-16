# IACardLink

The CardLink SDK provides a seamless process for users to scan their health cards and retrieve a list of
available prescriptions. Users can select the prescriptions they wish to redeem, and the SDK passes the selected receipts back to the host app.

## Health Card Scanning and Prescription Selection Flow:
1. **Health Card Scanning**: The SDK allows users to scan their health card by providing the CAN code.
2. **List of Medicine Receipts**: Once the card is scanned, the SDK retrieves a list of available medicine
  receipts (prescriptions).
3. **Selecting Prescriptions**: Users can select the prescriptions they wish to redeem from the list.
4. **Returning Selected Receipts**: The SDK provides the selected prescriptions to the host app.

## Requirements
iOS 15+

## Prerequisites
Before using CardLink, ensure that:
1. **SDK Initialization**: The IASDK must be initialized by calling IASDK.initialize().
2. **Prerequisites Shown**: All SDK prerequisites must be completed before starting CardLink.
3. **Module Registration**: The .cardlink module must be registered using IASDKModule.cardLink.register().

## Project setup
#### NFC setup
CardLink uses NFC, you will need to add some permissions to the host app so that SDK can use NFC capabilities.

1. Select your target and open **Signing and capabilities**. Click **+ Capability** and search for "Near Field Communication Tag Reading". Add it.
2. Add **Privacy - NFC Scan Usage Description** to your Info.plist and write description text for it.
3. Add **ISO7816 application identifiers for NFC Tag Reader Session** and add following strings to it:
- D2760001448000
- D27600014601
- D27600014606
- D27600000102
- A000000167455349474E
- D27600006601
- D27600014602
- E828BD080FA000000167455349474E
- E828BD080FD27600006601
- D27600014603

#### Localization
You will need to add **LocalizableNFC.xcstrings** file to your main target and define strings that SDK displays during the scanning process. Example of this file is 
[here](resources/LocalizableNFC.xcstrings)

## Authentication key
Use `IASDK.configuration.apiKey`. Do not use `CardLink.authenticationKey`.

## Configuration
The configuration object serves as an input to the CardLink SDK. It is used in CardLink.start function.

> [!IMPORTANT]
> You need to provide configuration object only if you are calling CardLink manually from your app (meaning you call CardLink.start).

```swift
var configuration = CardLinkConfiguration(
    pharmacyId: ...,
    consentStatus: ...,
    canCode: ...,
    phoneNumber: ...,
    userId: ...,
    cardName: ...,
    isSaveCardEnabled: ...,
    source: ...,
    appID: ...
)
```

**Parameters**
- *pharmacyId: String* (Required):
Use value returned from `IASDK.getPharmacyID`.

- *consentStatus: CardLinkConsentStatus* (Required):
Defines whether the consent screen should be shown or if the consent has already been accepted or declined. Possible values:
  - *.undetermined*: SDK will show consent.
  - *.accepted*: SDK will not show consent, phone number will be available to SDK.
  - *.declined*: SDK will not show consent, phone number will not be used.

- *canCode: String?* (Optional):
The CAN code from the user's health card. If provided, the SDK will skip the screen for entering the CAN number.

- *phoneNumber: String* (Required):
The phone number associated with the user. If consent is given, this number will be passed for verification. The phone number is automatically formatted to remove non-numeric characters except + at the start.

- *userId: String* (Required):
Used only for card saving feature, it saves and returns card for this userId.

- *cardName: String?* (Optional):
If set, the SDK will use the saved card with this name.

- *isSaveCardEnabled: Bool *(Required):
A flag indicating whether the "Save Card" feature is enabled. When enabled, users can save their card information for future use. Note: There is also a global isSaveCardEnabled setting on the CMS (for all clients); both must be true for this feature to work.

- *source: IASource (Optional, default: .unknown)*:
Indicates the starting point from where CardLink is presented. Used internally to decide whether to present the "Prescription added" bottom sheet at the end. Possible values:
- .cart
- .productDetails
- .startScreen
- .unknown

- *appID: String?*(Optional):
Used to open App Store page of your app from one of the info screens.

## Manually Start CardLink process
This is needed only if you want to start CardLink manually from your app, otherwise CardLink is called automatically from the SDK.

> [!IMPORTANT]
> Make sure that the `.cardlink` module is registered by calling IASDKModule.cardLink.register().
> Ensure that the SDK has been initialized and prerequisites have been shown before calling this.

After constructing your configuration, you are ready to start the CardLink process by calling *CardLink.start* and passing the configuration you created earlier. This will present CardLink’s initial screen on the given *rootViewController*. 

Note: if *rootViewController* is a *UINavigationController* then the SDK will **push** initial screen, otherwise it will **present** it.

```swift
CardLink.start(
      type: .startCardlink,
      forcePresent: false,
      on: rootViewController,
      configuration: configuration
) { action in
      switch action {
          // Handle actions
      }
  }
```

## CardLink.start Parameters
- **type**: CardlinkFlowType (Required) - Defines the type of flow to start:
 - .startCardlink: Starts the standard CardLink flow.
 - .startSavedCards: Starts the saved cards flow.
- **forcePresent**: Bool (Optional, default: false) - If true, forces the SDK to present the screen instead of pushing it, even if the root view controller is a UINavigationController.
- **on**: UIViewController (Required) - The root view controller on which to present or push the CardLink screen.
- **configuration**: CardLinkConfiguration (Required) - The configuration object containing all necessary
  parameters for starting CardLink.

## Handling actions
- **onOutputAction**: (_ action: CardLinkOutputAction) -> Void (Required) - A closure that receives output actions from CardLink. The `onOutputAction` closure receives CardLinkOutputAction events that you should handle:
  
- *consentAccepted(let phoneNumber: String)*
Sent when the user accepts the consent. You will want to save this information so you can pass it next time you start CardLink process.

- *consentDeclined:*
Sent when the user declines consent. You will want to save this information so you can pass it next time you start CardLink process.

- *sessionCreated(_ session: CardLinkSession):*
Sent when a new session is successfully created.
The CardLinkSession contains:
  - cardSessionId: String - The session identifier.
  - sessionExpiresAt: Int64 - The session expiration timestamp in milliseconds.

- *backButtonPressed:*
Sent when user tapped back button and CardLink should close. You should call CardLink.finish() here.

- *goToCart:*
Sent when the user selects the option to go to the cart.

- *openTermsAndConditions:*
Called when the user opts to view the terms and conditions on the consent screen. Host app is responsible for presenting terms and conditions.

- *prescriptionsRedeemed(_ prescription: String):*
Called when prescriptions are successfully redeemed. The prescription parameter provides the redeemed prescription data.

- *cardsSaved(cards: [CardData]):*
Called when the user saves their health card(s). The CardData array is provided for further processing. You can use this to save CAN numbers and then pass them to the start method next time.

- *addedPrescriptionsToCart(_ prescriptions: [EPrescriptionData]):*
Called when prescriptions are added to the cart. The array contains EPrescriptionData objects with prescription details.

- *willStartScanning:*
Called just before the NFC scanning process begins.

- *failedToInitialize(error: InitializationError):*
Called when CardLink fails to initialize. Possible error types:
- .missingAuthenticationKey: No authentication key was provided.
- .missingPharmacyID: The pharmacy ID is missing or empty.
- .failedToAuthenticate: Authentication with the provided key failed.
- .sdkNotInitialized: IASDK was not initialized before calling CardLink.
- .missingCardLinkEntitlement: The CardLink entitlement is not available.

- *trackEvent(String):*
Sent when an analytics event should be tracked. The string contains event details.

- *reopenCardlink:*
Sent when CardLink should be reopened (e.g., after an error or user action requiring a restart).

## UI customization
The CardLink SDK allows customization of its UI to match the look and feel of the host app. You can customize colors for primary elements, buttons, text links, and the bottom navigation bar.

```swift
CardLink.style = CardLinkStyle(
    primaryColor: .red, 
    buttonsColor: .black, 
    textLinkColor: .blue, 
    bottomNavigationColor: .green
)
```
## CardLinkStyle Parameters
All parameters are optional (UIColor? or Color?):
- primaryColor: The primary color used throughout the CardLink UI.
- buttonsColor: The color used for buttons.
- textLinkColor: The color used for text links.
- bottomNavigationColor: The color used for the bottom navigation bar.
You can initialize CardLinkStyle with either UIColor or SwiftUI Color types.

## Orientation
CardLink can run only in portrait mode so it is needed to restrict it from AppDelegate.

```swift
 private class AppDelegate: NSObject, UIApplicationDelegate {
      func application(
          _ application: UIApplication, 
          supportedInterfaceOrientationsFor window: UIWindow?
      ) -> UIInterfaceOrientationMask {
          InterfaceOrientationCoordinator.shared.supportedOrientations
      }
  }
```

## Environment
You can set the CardLink environment to specify which backend environment to use:
CardLink.environment = .production // .debugDEV, .debugQA, or .production

## CLEnvironment Values
- .production: Production environment (default)
- .debugQA: QA/staging environment
- .debugDEV: Development environment

## Public API
### CardLink Class
Public interface for CardLink module (accessed directly via `CardLink` class):

#### Configuration
- **CardLink.authenticationKey:** `CardLinkAuthenticationKey?` - Legacy authentication key. Do not use this for new
  integrations. Use `IASDK.configuration.apiKey` instead.
- **CardLink.style:** `CardLinkStyle` - Style for customizing CardLink appearance. Should be set before starting the
   CardLink process.
- **CardLink.environment:** `CLEnvironment` - Environment used in the CardLink SDK. Default is `.production`.
- **CardLink.defaultCardLinkConfiguration:** `CardLinkConfiguration?` - Default configuration used only when the SDK internally starts CardLink. The pharmacy ID will always be overridden with the one from the SDK.

#### Information
- *CardLink.version:* `String` - Returns the CardLink SDK version.
- *CardLink.logsPath:* `String`- Path to log files.

#### Card Management
- *CardLink.getSavedCards(userId:)* - Returns stored cards for a user
```swift
  func getSavedCards(userId: String) -> [CardData]?
```

- *CardLink.deleteCard(userId:name:)* - Deletes a specific card. Throws CardStorageError.deleteCardsUnsuccessfully if deletion fails.
```swift
  func deleteCard(userId: String, name: String) throws
```

- *CardLink.deleteAllCards()* - Deletes all user-saved cards.
- Returns:
    - `.successDeleteAll`: All cards were successfully deleted.
    - `.emptyStorage`: Storage was already empty.
```swift
  func deleteAllCards() throws -> CardStorageStatus
```

- *CardLink.deleteAllUserRelatedData()* - Deletes all user-saved cards and other user-related data.
```swift
  func deleteAllUserRelatedData() async throws
```

#### Flow Control
- CardLink.start(type:forcePresent:on:configuration:onOutputAction:) - Starts the CardLink flow.
```swift
func start(
      type: CardlinkFlowType,
      forcePresent: Bool = false,
      on rootViewController: UIViewController,
      configuration: CardLinkConfiguration,
      onOutputAction: @escaping (_ action: CardLinkOutputAction) -> Void
  )
```

 - CardLink.finish(completion:) - Finishes the CardLink flow.
```swift
   func finish(completion: EmptyCallback? = nil)
```

## Supporting Types
## CardData
Represents saved card information.
```swift
  public struct CardData: Codable, Identifiable, Hashable {
      public let id: String
      public let name: String
      public let canNumber: String
      public let phoneNumber: String
  }
```

## CardLinkAuthenticationKey
Legacy authentication key structure.
```swift
   public struct CardLinkAuthenticationKey: ExpressibleByStringLiteral {
      public let value: String
      public let headers: [String: String]?

      public init(value: String, headers: [String: String]? = nil)
  }
```

## CardStorageError
Errors that can occur during card storage operations:
 ```swift
   public enum CardStorageError: Error {
      case duplicateCard
      case cardNotFound
      case invalidCard
      case deleteCardsUnsuccessfully
  }
```

## CardStorageStatus
Status returned from card storage operations:
```swift
    public enum CardStorageStatus {
      case successDeleteAll
      case emptyStorage
  }
```

## EPrescriptionData
Represents electronic prescription data:
```swift
  public struct EPrescriptionData: Codable, Sendable, Equatable {
      public let rawCode: String
      public let urls: [String]
      public let cardLinkEPrescription: CardLinkEPrescription?
      public let rawCodeHash: String
  }
```

## CardLinkEPrescription
Represents detailed prescription information:
```swift
   public struct CardLinkEPrescription: Codable, Sendable, Equatable {
      public let type: String
      public let authoredOn: String
      public let organization: String
      public let title: String?
      public let code: String?
      public let dosageInstruction: String
      public let ingredients: [String]?
      public let strength: String?
      public let unit: String?
      public let form: String?
      public let medicationName: String?
      public let ingredientName: String?
  }
```

## Module Registration
To use CardLink with IASDK, you must register the module:
```swift
 IASDKModule.cardLink.register()
```
 This should be done before calling `IASDK.initialize()`.
