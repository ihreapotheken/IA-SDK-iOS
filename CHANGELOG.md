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
