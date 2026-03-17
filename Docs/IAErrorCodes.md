# IAErrorCode Documentation

This document provides a comprehensive overview of all predefined error codes in the IA SDK, organized by category. Each error code includes its numeric identifier and description of when it occurs.

## Overview

- **1xx**: General and Setup Errors
- **2xx**: Registration and Entitlement Errors
- **3xx**: SDK-Specific Feature Errors
- **5xx**: Development and Runtime Errors
- **7xx**: Swift System Errors (Camera)

---

## General Errors (1xx)

| Code | Title | Description |
|------|-------|-------------|
| 100 | `unknownError` | An unexpected failure that doesn't match any predefined error code. |
| 1000 | `notImplementedError` | The requested functionality has not yet been implemented. |

---

## Setup Errors (1xx - Initialization)

These errors occur during SDK initialization and configuration. They prevent the SDK from functioning properly until resolved.

| Code | Title | Description |
|------|-------|-------------|
| 101 | `failedToFetchEntitlements` | Entitlement data could not be fetched from the server during SDK initialization due to network or server issues. |
| 102 | `failedToFetchSDKConfiguration` | SDK configuration could not be retrieved from the remote server. Configuration endpoints are unreachable or returned invalid data. |
| 103 | `failedToFetchBEPConfiguration` | BEP configuration could not be retrieved during initialization. |
| 104 | `failedToFindClientID` | The SDK could not locate or identify the client ID in the configuration during setup. |
| 105 | `prerequisitesGeneralError` | A general error occurred during prerequisites validation that doesn't fall into specific categories. |
| 106 | `apiKeyNotValid` | The provided API key is invalid or expired. Authentication failed. |
| 107 | `apiKeyNotProvided` | The mandatory API key parameter was not provided during SDK initialization. |
| 108 | `clientIDNotProvided` | The required client ID parameter was not provided during initialization. |
| 109 | `bundleIDNotProvided` | The app's bundle identifier is missing or could not be determined. |
| 110 | `invalidPharmacyAndApofinderNotEnabled` | The selected pharmacy is invalid and ApoFinder feature is not enabled as a fallback option. |
| 111 | `initializationAlreadyInProgress` | SDK initialization is already in progress. Cannot initialize while initialization is ongoing. |
| 112 | `sdkNotInitialized` | SDK functionality was called before initialization completed. |
| 113 | `noModulesRegistered` | Initialization completed but no feature modules are available. |
| 114 | `prerequisitesInProgress` | Operations cannot be performed while prerequisite validation is in progress. |
| 115 | `triedToPerformNetworkRequestBeforeSDKInitialization` | A network request was attempted before the SDK finished initializing. |

---

## Registration & Entitlement Errors (2xx)

These errors indicate missing or invalid entitlements for specific SDK features. They occur when attempting to use features not enabled for your ID.

| Code | Title | Description |
|------|-------|-------------|
| 201 | `iaIntegrationsNotRegistered` | The IA Integrations module was not properly registered during initialization. |
| 202 | `missingEntitlements` | Entitlement data is missing, invalid, or could not be retrieved. |
| 203 | `missingEntitlementForOverTheCounter` | Over-the-counter (OTC) feature is not enabled for this account. |
| 204 | `missingEntitlementForPharmacy` | Pharmacy features are not enabled for this account. |
| 205 | `missingEntitlementForPrescriptions` | Prescription handling features are not enabled for this account. |
| 206 | `missingEntitlementForCardLink` | CardLink is not enabled for this account. |
| 207 | `missingEntitlementForApoFinder` | ApoFinder is not enabled for this account. |
| 208 | `missingEntitlementForOrdering` | Cart and Checkout features are not enabled for this account. |
| 209 | `missingRemoteConfigurationInfrastructureMetaData` | Essential configuration infrastructure metadata is not available from the server. |

---

## SDK-Specific Feature Errors (3xx)

These errors are specific to individual SDK features and modules, indicating configuration or operational issues within those features.

### CardLink Errors (301-305)

| Code | Title | Description |
|------|-------|-------------|
| 301 | `cardLinkMissingAuthKey` | The required authentication key for CardLink was not provided. |
| 302 | `cardLinkMissingPharmacyID` | The required pharmacy ID for CardLink was not provided. |
| 303 | `cardLinkFailedToAuthenticate` | CardLink authentication failed due to invalid credentials. |
| 304 | `cardLinkSDKNotInitialized` | CardLink was used before the module was initialized. |
| 305 | `cardLinkConfigurationNotSet` | CardLink configuration is missing. |

### Ordering/Cart Errors (306-311)

| Code | Title | Description |
|------|-------|-------------|
| 306 | `orderingCartBadPZN` | The product identifier (PZN) in the cart doesn't match expected format or is invalid. |
| 307 | `orderingCartDraftIDMissing` | Cart operations require a draft ID that hasn't been created or was lost. |
| 308 | `orderingCartTooManyPrescriptions` | The cart exceeds the maximum number of allowed prescription items. |
| 309 | `orderingCartInvalidItem` | The cart contains an item that doesn't meet validation requirements. |
| 310 | `orderingCartDuplicated` | Attempted to create a cart that already exists. |
| 311 | `orderingDuplicatedEPrescription` | The same e-prescription was added to the cart multiple times. |

---

## Development & Runtime Errors (5xx)

These errors typically occur during development or runtime due to invalid data, missing resources, or operational failures.

### General Development Errors (501-507)

| Code | Title | Description |
|------|-------|-------------|
| 501 | `missingGuestUser` | Operations require a guest user context but none exists. |
| 502 | `missingPharmacyID` | Pharmacy-specific operations require a pharmacy ID that was not provided. |
| 503 | `pharmacyNotFound` | The specified pharmacy ID doesn't match any existing pharmacy. |
| 504 | `productInvalidAmount` | Product quantity is zero, negative, or exceeds limits. |
| 505 | `productWithoutPrice` | The product is missing price information. |
| 506 | `missingTopPresentedViewController` | The SDK needs to present UIViewController but cannot determine the top-most view controller. |
| 507 | `unableToOpenLink` | The URL is invalid or cannot be handled by the system. |

### Data & Encoding Errors (508-513)

| Code | Title | Description |
|------|-------|-------------|
| 508 | `hugeImage` | The image dimensions are too large for processing. |
| 509 | `corruptedImage` | The image data is corrupted or invalid and cannot be decoded. |
| 510 | `unableToEncodeData` | Data cannot be serialized or encoded to the required format. |
| 511 | `corruptedURL` | The URL string is malformed and cannot be parsed. |
| 512 | `corruptedMultipartData` | The multipart form data is invalid or incomplete. |
| 513 | `invalidServerResponse` | The server returned unexpected data structure or content type. |

### SSL/Security Errors (514-518)

| Code | Title | Description |
|------|-------|-------------|
| 514 | `sslFailedToGetServerTrust` | The SSL/TLS handshake failed to establish server trust. |
| 515 | `sslFailedToFindLeafCertificate` | The leaf certificate is missing or the certificate chain is incomplete. |
| 516 | `sslFailedToGetLeafCertificatePublicKey` | The public key could not be extracted from the leaf certificate. |
| 517 | `sslUntrustedServerCertificate` | The server certificate is self-signed, expired, or not from a trusted CA. |
| 518 | `sslPublicKeyNotAllowed` | The server's public key doesn't match the pinned keys. SSL pinning validation failed. |

---

## Swift System Errors (7xx)

Camera-specific errors that occur when using device camera functionality.

| Code | Title | Description |
|------|-------|-------------|
| 719 | `cameraNoCaptureDeviceAvailable` | The device has no camera or the camera is unavailable (e.g., running on simulator). |
| 720 | `cameraCaptureDeviceInputUnavailable` | The camera input cannot be created or accessed. |
| 721 | `cameraUnableToAttachInputDeviceToSession` | The camera session configuration failed when attaching the input device. |
| 722 | `cameraUnableToAttachOutputDeviceToSession` | The camera session configuration failed when attaching the output device. |
| 723 | `cameraFlashlightUnavailable` | The device doesn't support flash or it's currently unavailable. |
| 724 | `cameraUnableToCapturePhoto` | Photo capture failed for various reasons. |
| 725 | `cameraCapturedPhotoDataUnavailable` | Photo capture completed but the data could not be retrieved. |
| 726 | `cameraCapturedPhotoDataInvalidUIImage` | The captured photo data is invalid or corrupted and cannot be converted to UIImage. |
| 727 | `cameraInvalidConfiguration` | The camera settings or session configuration is incorrect. |
| 728 | `cameraUnableToFocus` | Autofocus failed or manual focus could not be set. |
| 729 | `generalCameraError` | An unexpected camera failure that doesn't fit other categories. |
