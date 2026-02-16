# All modules and features

## IACore
- IASDK.configuration: struct on which you can set various options like apiKey, clientID, footer options, initializationType etc. 
- IASDK.register
- IASDK.initialize
- IASDK.setDelegates
- IASDK.setSingleDelegate
- IASDK.setEnvironment
- IASDK.getEnvironment
- IASDK.Pharmacy.setPharmacyID
- IASDK.Pharmacy.getPharmacyID

## IAIntegrations
### Modules that can be registered in IASDK.register
- **IASDKModule.integrations**
  - Mandatory, contains various features used in SDK
- **IASDKModule.apofinder**
  - Allows user to change pharmacy from list or map
  - Shows Apofinder as part of the Prerequisits flow
  - Apofinder is available from *IAPharmacyScreen*

### Screens
- IAStartScreen: Screen intended to be used as starting point or home screen. 

### Other
- IAIntegrationsSDK.Prerequisites.resetAllPrerequisites
- IAIntegrationsSDK.Prerequisites.resetLegalDisclaimer
- IAIntegrationsSDK.Prerequisites.setIsOnboardingShown

## IAOverTheCounter
### Modules that can be registered in IASDK.register
- **IASDKModule.overTheCounter**
  - product grids (products of the month, current offers etc.) are shown on *IACartScreen* and *IAStartScreen*.
  - product search and product details are accessible from *IAStartScreen*, *IACartScreen* etc.

### Screens
- IAProductSearchScreen: Product search with filters.

## IAOrdering
### Modules that can be registered in IASDK.register
- **IASDKModule.ordering**
  - user can add products to cart. Cart button is displayed on product list, grids and details.
  - round cart button that opens *IACartScreen* is shown on *IAStartScreen*,  *IAProductSearchScreen* and *IAPharmacyScreen*
  - express delivery section is shown on *IAStartScreen*
  - recent orders section is shown on *IAStartScreen*

### Screens
- IACartScreen: Cart, checkout, thank you etc.

### Other
- IAOrderingSDK.deleteCart
- IAOrderingSDK.getCartDetails

## IAPharmacy
### Modules that can be registered in IASDK.register
- **IASDKModule.pharmacyDetails**
  - *IAPharmacyScreen* can be opened from *IAStartScreen* and *IACartScreen*

### Screens
- IAPharmacyScreen: Pharmacy details

## IAPrescription
### Modules that can be registered in IASDK.register
- **IASDKModule.prescription**
  - User can add prescriptions to the cart (scan and take photo). Accessible from *IAStartScreen* , *IACartScreen* and product details.

### Screens
- IAScannerScreen: Take photo of prescription or scan E-Prescription.

## IACardLink
### Modules that can be registered in IASDK.register
- **IASDKModule.cardLink**
  - User can scan electronic health cards and add prescriptions to the cart. Accessible from *IAStartScreen* , *IACartScreen* and product details.

### Other
  - CardLink: Class that can be used to manually start CardLink flow and set options.
  - CardLink.start
  - CardLink.getSavedCards
  - CardLink.deleteCard
  - CardLink.deleteAllCards


