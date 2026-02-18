# IACardLink

The Cardlink SDK provides a seamless process for users to scan their health cards and retrieve a list of available prescriptions. Users can select the prescriptions they wish to redeem, and the SDK passes the selected receipts back to the host app.

## Health Card Scanning and Prescription Selection Flow:
1. **Health Card Scanning**: The SDK allows users to scan their health card by providing the CAN code.
2. **List of Medicine Receipts**: Once the card is scanned, the SDK retrieves a list of available medicine receipts (prescriptions).
3. **Selecting Prescriptions**: Users can select the prescriptions they wish to redeem from the list.
4. **Returning Selected Receipts**: The SDK provides the selected prescriptions to the host app.

## Requirements
iOS 15

## Installation
To add the CardLink SDK to your Xcode project, follow these steps:
1. Open your Xcode project (or workspace), then go to **File > Add Package Dependencies...**
2. Enter https://github.com/ihreapotheken/CardLinkSDK-iOS into **Search or Enter Package URL** field. 
3. Specify a version and choose Target.
<img width="692" height="329" alt="setup1" src="https://github.com/user-attachments/assets/d401c7e0-c3be-43ff-bd0a-51ba73d07d69" />
   
5. Click **Add Package**
6. From the **Choose Package Products** window, verify that your main target is selected and click **Add Package**.

## Project setup
#### NFC setup
CardLink uses NFC, you will need to add some permissions to the host app so that SDK can use NFC capabilities.

1. Select your target and open **Signing and capabilities**. Click **+ Capability** and search for "Near Field Communication Tag Reading". Add it.
2. Add **Privacy - NFC Scan Usage Description** to your Info.plist and write description text for it.
3. Add **ISO7816 application identifiers for NFC Tag Reader Session** and add following strings to it:
4. D2760001448000, D27600014601, D27600014606, D27600000102, A000000167455349474E, D27600006601, D27600014602, E828BD080FA000000167455349474E, E828BD080FD27600006601, D27600014603

#### Localization
You will need to add **LocalizableNFC.xcstrings** file to your main target and define strings that SDK displays during the scanning process. Example of this file is 
[here](resources/LocalizableNFC.xcstrings)

## Authentication key
Use `IASDK.configuration.apiKey`. Do not use `CardLink.authenticationKey`.

## Configuration
Configuration object serves as a input to the CardLink SDK. It is used in CardLink.start function. You need to provide configuration object only if you are calling CardLink manually from your app.

```swift
var configuration = CardLinkConfiguration(
    pharmacyId: ...,
    consentStatus: ...,
    canCode: ...,
    phoneNumber: ...,
    userId: ...,
    cardName: ...,
    appID: ...
)
```

**Parameters**
- *pharmacyId: String* (Required):
Use value returned from `IASDK.getPharmacyID`.

- *consentStatus: CardLinkConsentStatus* (Required):
Defines whether the consent screen should be shown or if the consent has already been accepted or declined. Possible values:
  - *undetermined*: SDK will show consent.
  - *accepted*: SDK will not show consent, phone number will be available to SDK.
  - *declined*: SDK will not show consent, phone number will not be used.

- *canCode: String?* (Optional):
The CAN code from the user's health card. If provided, SDK will skip screen for inputing CAN number.

- *phoneNumber: String* (Required):
The phone number associated with the user. If consent is given, this number will be passed for verification. If not provided, the phone number can be entered within the SDK.

- *userId: String* (Required):
Used only for card saving feature, it saves and returns card for this userId.

- *cardName: String?* (Optional):
If set it will use saved card.

- *isSaveCardEnabled: Bool *(Required):
A flag indicating whether the "Save Card" feature is enabled. When enabled, users can save their card information for future use.

- *appID: String?*(Optional):
Used to open AppStore page of your app from one of the info screens.

## Start CardLink process
After constructing your configuration, you are ready to start the CardLink process by calling *CardLink.start* and passing the configuration you created earlier. This will present CardLink’s initial screen on the given *rootViewController*. 

Note: if *rootViewController* is a *UINavigationController* then the SDK will **push** initial screen, otherwise it will **present** it.

```swift
CardLink.start(on: rootViewController, configuration: configuration) { action in
    switch action {
        // Handle actions
    }
}
```

## Handling actions
- *consentAccepted(let phoneNumber: String)*
Sent when the user accepts the consent. You will want to save this information so you can pass it next time you start CardLink process.

- *consentDeclined:*
Sent when the user declines consent. You will want to save this information so you can pass it next time you start CardLink process.

- *sessionCreated(_ session: CardLinkSession):*
Sent when a new session is successfully created.

- *backButtonPressed:*
Sent when user tapped back button and CardLink should close. You should call CardLink.finish() here.

- *goToCart:*
Sent when the user selects the option to go to the cart.

- *openTermsAndConditions:*
Called when the user opts to view the terms and conditions on the consent screen. Host app is responsible for presenting terms and conditions.

- *prescriptionsRedeemed(_ prescription: String):*
Called when prescriptions are successfully redeemed. The prescription parameter provides the redeemed prescription data.

- *cardSaved(_ card: CardData):*
Called when the user saves their health card (after entering CAN number). The CardData structure is provided for further processing if needed. You can use it to save CAN number and then pass it to start method next time.

## UI customization
The Cardlink SDK allows customization of its UI to match the look and feel of the host app. You can customize colors for primary elements, buttons, text links, and the bottom navigation bar.

```swift
CardLink.style = CardLinkStyle(
    primaryColor: .red, 
    buttonsColor: .black, 
    textLinkColor: .blue, 
    bottomNavigationColor: .green
)
```

## Orientation
CardLink can run only in portrait mode so it is needed to restrict it from AppDelegate.

```swift
private class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        InterfaceOrientationCoordinator.shared.supportedOrientations
    }
}
```
