## 2.6.0

### Features
- Added search functionality to the Log Entry Details screen on iOS.
- Added an error screen during the prerequisites flow when the previously selected pharmacy has been deleted, allowing users to navigate to select a new pharmacy.
- Updated the availability status text on the Product Detail Page for products that are only available by inquiry.
- Added price display for pharmaceutical care services (PDL), showing the applicable cost for both public and private insurance types when a price is available.
- Added an informational hint box to the CardLink NFC scan screen to guide users to the FAQ when scanning is not possible.
- Added haptic feedback support for various interactions, with an option for partners to enable or disable the feature.
- Expanded Report a Problem with the ability to view orders and contact the pharmacy, suggest new features, and leave general comments
- Updated the CardLink saved medical cards screens with improved navigation, a redesigned edit screen for managing card details (name, phone number, CAN code), a reorder button for the cards list, a search option when more than 10 cards are saved, and various UI label and layout adjustments.

### Fixes
- Improved text field behavior including text selection and autocomplete handling.

### Breaking changes
- CardLinkConfiguration.coreAppLogFileURL has been removed. Use IASDK.configuration.hostAppLogFileURL.

## 2.5.0

### Features
- Added appointment booking for vaccinations and other pharmaceutical services at selected pharmacies. Users can now schedule appointments and receive support and medical advice from their chosen pharmacy.
- Added support for prefilling billing and delivery addresses for guest users, allowing the host app to provide address data that will be pre-populated in the address form during checkout.
- Added informational countdown and retry guidance during SMS/OTP delivery in the CardLink flow, including messaging for delayed or failed SMS delivery and warnings after multiple unsuccessful attempts.
- Beta version suffix is now shown as 'b' instead of 'beta' (e.g. 2.5.0(b1)).
- Exposed the pharmacy selection flow (Apofinder) as a standalone module, allowing host apps to integrate and place the pharmacy selection experience at any point in their app.
- Added support for selecting a pharmacy via code scan.
- Added an exposed module for prescription redemption, allowing SDK partners to integrate a fully configurable prescription redemption entry point directly into their host app.

### Fixes
- Fixed test pharmacies not being selectable on the apofinder type selection screen
- Fixed an issue on the product details screen where the bottom portion of the screen could not be scrolled or tapped after adding a product to the cart.
- Removed the deletion confirmation bottom sheet when removing an unavailable product.
- Fixed auto-scrolling issues on iOS 16.
- Fixed Keyboard Toolbar background not appearing consistently when the SDK is used in cross-platform environments.
- Updated the display of manufacturer name for own PZN prescriptions to correctly show the registered trade name alongside the manufacturer name when third-party manufacturing is selected.

### Breaking changes
- None

## 2.4.2

### Features
- None

### Fixes
- Fixed email validation to better comply with standard email address formatting rules.

### Breaking changes
- None

## 2.4.1

### Features
- Added force update support during SDK initialization, displaying a native alert when the SDK version is below the required minimum version, with soft updates allowing continued usage and hard updates blocking initialization.

### Fixes
- None

### Breaking changes
- Removed CardLinkConfiguration.appID (Use IASDK.configuration.appStoreID).

## 2.4.0

### Features
- Added an optional `coreAppLogFilePath` parameter to the SDK launch method, allowing the host app to provide a log file path that will be included in the "Report a Problem" submission.
- Added UI to inform users when a product in their basket has become unavailable during checkout.
- Added E-Prescription details to order history when orders are added via CardLink.
- Updated the CardLink prescription redemption entry point from a bottom sheet to a full-screen experience, including a carousel for up to three cards, new eGK design with pharmacy logo, and options to view, add, edit, and rearrange all cards.
- Improved CardLink prescription detail and overview screens to display additional data points, including package size with units, updated and expiry dates in German date format, emergency fee, cost bearer type with localized labels, and mapped country codes to full German country names.
- Logger: Added session number tracking to logs and improved crash detection for background autosave tasks.
- Added a login screen for guest users whose email address matches an existing account, allowing them to sign in with their password during the appointment booking flow.
- Added product scanner.

### Fixes
- Fixed missing 'SDK' label on 'Report a problem' tickets submitted via Cardlink.
- Fixed an issue where the cart screen was showing an indefinite loading indicator after performing a prescription transfer.

### Breaking changes
- Module protocols (ApofinderModule, OrderingModule etc.) are not public anymore.

## 2.3.0

### Features
- Updated the Product Detail Page with new functionality and improvements.
- Cardlink - added arrow for banner explanation
- Created Additional Tracking Events
- CardLink - Transfered all prints to logs
- CardLink: Added Success Message Snack Bar After Card was Added
- Updated pharmacy display name to include additional information (Zusatzinformation) appended to the original pharmacy name.
- Added SDK version to the footer.
- Updated the billing address bottom sheet to display 'Rechnungsadresse' in bold when an address is present, and to show 'Noch keine Rechnungsadresse hinterlegt.' when no billing address has been added.
- Changed display of manufacturer name on the product detail page for Own-PZN items.
- Added product scanner
- Added IAProductGrid component
- Added IACartButton component

### Fixes
- Minor: FAQ Text Changes
- Cardlink - when save card feature is off in strapi, we can still see old saved cards
- Fixed filter UI layout in the Apofinder to properly handle larger font sizes without breaking icons or text.

### Breaking changes
- None
