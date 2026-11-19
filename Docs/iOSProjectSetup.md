# iOS Project Setup

This guide covers the iOS project setup the IA SDK needs: Info.plist keys, capabilities, resources and orientation. It applies to native iOS apps and to apps using one of the IA SDK plugins (Flutter, NativeScript, React Native). Where a plugin does something differently, see [Platform specifics](#platform-specifics) at the bottom.

## 1. Permissions

Add the following keys to your `Info.plist` file. Location and camera are always required, NFC only with the CardLink module.

In Xcode, open `Info.plist` in the property list editor and add a row for each key below; you can type the raw key names, Xcode shows them by their display names (e.g. "Privacy - Camera Usage Description"). Alternatively, open the file as source code (right-click > **Open As > Source Code**) and add the keys inside the top-level `<dict>`, but first check that none of them already exist, since duplicate keys are not allowed.

```xml
<!-- Location permission - always required, used by Apofinder (pharmacy search) -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>Used to show pharmacies nearby.</string>

<!-- Camera permission - always required, used by the pharmacy code scanner, product scanner and prescription scanner -->
<key>NSCameraUsageDescription</key>
<string>Camera access is needed to scan pharmacy codes, products and prescriptions.</string>

<!-- NFC permission - required for CardLink module -->
<key>NFCReaderUsageDescription</key>
<string>NFC is used to read your health insurance card for prescription redemption.</string>

<!-- NFC card application identifiers (AIDs) - required for CardLink module, used to communicate with German health insurance cards (eGK) -->
<key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
<array>
    <string>D2760001448000</string>
    <string>D27600014601</string>
    <string>D27600014606</string>
    <string>D27600000102</string>
    <string>A000000167455349474E</string>
    <string>D27600006601</string>
    <string>D27600014602</string>
    <string>E828BD080FA000000167455349474E</string>
    <string>E828BD080FD27600006601</string>
    <string>D27600014603</string>
</array>
```

The description texts above are examples. Write your own texts that fit your app; they are shown to the user when the permission is requested.

## 2. CardLink (NFC)

Skip this section if you don't use the CardLink module.

- **NFC permission**: Add the NFC keys from [Permissions](#1-permissions).
- **NFC capability**: Add the "Near Field Communication Tag Reading" capability in your app target's **Signing & Capabilities**.
  Make sure the reader session formats in the target's `.entitlements` file include `TAG`:
  ```xml
  <key>com.apple.developer.nfc.readersession.formats</key>
  <array>
      <string>TAG</string>
  </array>
  ```
- **Localization**: Add the [`LocalizableNFC.xcstrings`](resources/LocalizableNFC.xcstrings) file to your app target. It contains the texts shown in the system NFC sheet during scanning, in German and English. Don't change the file; add it as it is.

> [!IMPORTANT]
> The texts in `LocalizableNFC.xcstrings` change from time to time. When the [CHANGELOG](../CHANGELOG.md) says the file was updated, download it again and replace your copy.

## 3. Orientation

The IA SDK supports only portrait mode, so restrict your app to portrait. In your target's **General > Deployment Info**, select only **Portrait**, or set it in your `Info.plist`:

```xml
<key>UISupportedInterfaceOrientations</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
</array>
<key>UISupportedInterfaceOrientations~ipad</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
</array>
<!-- iPad only: without it, iPad multitasking requires all orientations -->
<key>UIRequiresFullScreen</key>
<true/>
```

## 4. Liquid Glass

The IA SDK supports Liquid Glass, starting from iOS 26.0. To enable it, set `UIDesignRequiresCompatibility` to `false` in your `Info.plist`:

```xml
<key>UIDesignRequiresCompatibility</key>
<false/>
```

Then also enable it in the SDK configuration, see [Appearance](Appearance.md#liquid-glass).

## Platform specifics

### Flutter

- All the setup above goes into the Runner target: open `ios/Runner.xcworkspace` in Xcode.
- `Info.plist` is `ios/Runner/Info.plist`, the entitlements file is `ios/Runner/Runner.entitlements`.
- The CardLink module is the `ia_cardlink` package.
- Add `LocalizableNFC.xcstrings` to the Runner target in Xcode (e.g. `ios/Runner/LocalizableNFC.xcstrings`), so it is included in the app bundle.

### NativeScript

- `Info.plist` is `App_Resources/iOS/Info.plist`; NativeScript merges it into the generated Xcode project.
- The CardLink module is not available in the NativeScript plugin, so skip the NFC keys and the [CardLink (NFC)](#2-cardlink-nfc) section.

### React Native

- All the setup above goes into your app target: open `ios/<YourApp>.xcworkspace` in Xcode.
- `Info.plist` is `ios/<YourApp>/Info.plist`, the entitlements file is `ios/<YourApp>/<YourApp>.entitlements`.
- The CardLink module is the `@ihreapotheken/ia-sdk-cardlink` package.
- Add `LocalizableNFC.xcstrings` to your app target in Xcode (e.g. `ios/<YourApp>/LocalizableNFC.xcstrings`), so it is included in the app bundle.
