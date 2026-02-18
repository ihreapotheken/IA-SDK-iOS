# SDK Public API Overview

This document provides an overview of all public interfaces available in the IA SDK.

## IACore

### IASDK Main Interface

#### Configuration and Setup
- `IASDK.configuration` - Configuration properties (apiKey, clientID, etc.)
- `IASDK.register(_ modules:)` - Registers SDK modules
- `IASDK.setDelegate(_ delegate:)` - Sets delegate to receive callbacks
- `IASDK.setEnvironment(_ environment:)` - Sets SDK environment (production/staging)
- `IASDK.getEnvironment()` - Returns current SDK environment

#### Initialization
- `IASDK.initialize(options:)` - Initializes SDK with optional prerequisites flow
- `IASDK.initialize(shouldShowIndicator:prerequisitesOptions:)` - Convenience initialization method
- `IASDK.initializationState` - Returns current initialization state
- `IASDK.initializationStatePublisher` - Publisher that emits initialization state updates
- `IASDK.cleanCache(initialization:prerequisites:)` - Clears cached data for testing

#### Module Accessors
- `IASDK.overTheCounter` - Returns IAOverTheCounterSDK instance (throws if module not registered)
- `IASDK.ordering` - Returns IAOrderingSDK instance (throws if module not registered)
- `IASDK.pharmacy` - Returns IAPharmacySDK instance (throws if module not registered)
- `IASDK.prescription` - Returns IAPrescriptionSDK instance (throws if module not registered)

#### Pharmacy Management
- `IASDK.Pharmacy.savePharmacyID(_ pharmacyID:)` - Saves pharmacy ID without setting it, use it be before initialization only. After initializazion use `setPharmacyID`
- `IASDK.Pharmacy.setPharmacyID(_ pharmacyID:)` - Changes current pharmacy with validation
- `IASDK.Pharmacy.getPharmacyID()` - Returns currently selected pharmacy ID
- `IASDK.Pharmacy.getPharmacy(allowCached:)` - Returns current pharmacy object

#### User Management
- `IASDK.setUserData(_ userData:)` - Sets user data for checkout
- `IASDK.deleteUser()` - Deletes all stored user data
- `IASDK.clearAllData()` - Deletes all user-related data from SDK

#### Prerequisites Management
- `IASDK.Prerequisites.resetAllPrerequisites()` - Resets all prerequisite-related data
- `IASDK.Prerequisites.resetLegalDisclaimer()` - Resets legal acceptance flags
- `IASDK.Prerequisites.setIsOnboardingShown(_ value:)` - Sets onboarding shown flag

### UI components

- **IAStartScreen** - Starting point or home screen with product grids, recent orders, and express delivery
- **IAProductSearchScreen** - Product search with filters
  - `.focusesOnAppear(_ shouldFocusOnStart:)` - Modifier to control search field focus
- **IACartScreen** - Cart, checkout, and thank you screens
- **IAPharmacyScreen** - Pharmacy details and information
- **IAScannerScreen** - Take photo of prescription or scan E-Prescription
  - `.isCameraOn(_ binding:)` - Modifier to control camera state
  - `.onCameraError(_ errorHandler:)` - Modifier to handle camera errors

## IAIntegrations

### Modules
- **IASDKModule.integrations**
- **IASDKModule.apofinder**

### UI components
- IAStartScreen

## IAOverTheCounter

### Modules
- **IASDKModule.overTheCounter**
  - Use `IASDK.overTheCounter` to access the module interface.

### UI components
- IAProductSearchScreen

## IAOrdering

### Modules
- **IASDKModule.ordering**
  - Use `IASDK.ordering` to access the module interface.

### UI components
- IACartScreen

### Functions (via IASDK.ordering)
- `deleteCart()` - Deletes cart from internal storage
- `getCartDetails(allowCached:throwIfNil:shouldEmit:)` - Returns current cart details
- `transferPrescriptions(images:pdfs:codes:orderID:showActivityIndicator:finishAction:)` - Uploads and adds prescriptions to cart
- `cartStateNotifier(_ type:)` - Returns publisher that emits cart state updates

## IAPharmacy

### Modules
- **IASDKModule.pharmacy**
  - Use `IASDK.pharmacy` to access the module interface.

### UI components
- IAPharmacyScreen

## IAPrescription

### Modules
- **IASDKModule.prescription**
  - Use `IASDK.prescription` to access the module interface.

### UI components
- IAScannerScreen

## IACardLink

### Modules
- **IASDKModule.cardLink**
  Use `CardLink` to access the module interface.

### CardLink Class
Public interface for CardLink module (accessed directly via `CardLink` class):

#### Configuration
- `CardLink.authenticationKey` - Authentication key (must be set before calling start)
- `CardLink.style` - Style for customizing CardLink appearance
- `CardLink.environment` - Environment used in CardLink SDK
- `CardLink.defaultCardLinkConfiguration` - Default configuration when SDK starts CardLink

#### Information
- `CardLink.version` - Returns CardLink version
- `CardLink.logsPath` - Path to log files

#### Card Management
- `CardLink.getSavedCards(userId:)` - Returns stored cards for user
- `CardLink.deleteCard(userId:name:)` - Deletes a specific card
- `CardLink.deleteAllCards()` - Deletes all user-saved cards
- `CardLink.deleteAllUserRelatedData()` - Deletes all user-related data

#### Flow Control
- `CardLink.start(type:forcePresent:on:configuration:onOutputAction:)` - Starts CardLink flow
- `CardLink.finish(completion:)` - Finishes CardLink flow
