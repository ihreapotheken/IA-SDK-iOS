// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IASDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "IAOverTheCounter",
            targets: ["IAOverTheCounterWrapper"]
        ),
        
            .library(
                name: "IAOrdering",
                targets: ["IAOrderingWrapper"]
            ),
        
            .library(
                name: "IAPharmacy",
                targets: ["IAPharmacyWrapper"]
            ),
        
            .library(
                name: "IACardLink",
                targets: ["IACardLinkWrapper"]
            ),
        
            .library(
                name: "IAIntegrations",
                targets: ["IAIntegrationsWrapper"]
            ),
        
            .library(
                name: "IAPrescription",
                targets: ["IAPrescriptionWrapper"]
            )
    ],
    dependencies: [
        .package(url: "https://github.com/gematik/OpenSSL-Swift", exact: "4.3.1"),
    ],
    targets: [
        // IOSKit
        .binaryTarget(
            name: "IOSKit",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/1.0.0-beta.1/IOSKit-1.0.0-beta.1.xcframework.zip",
            checksum: "b3923ff2f73bab66094866861b0af62ad970dd24cf8928354cf25244b13edb2e"
        ),
        
        // IACore
        .binaryTarget(
            name: "IACore",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/1.0.0-beta.1/IACore-1.0.0-beta.1.xcframework.zip",
            checksum: "39d7f8ba52c2f57c4f02c886ae834a0efc0d75b99ed2d3b403bd51b5cced0199"
        ),
        .target(
            name: "IACoreWrapper",
            dependencies: [ 
                .target(name: "IOSKit"),
                .target(name: "IACore"),
                .target(name: "IAOverTheCounter"),
            ],
            path: "Sources/IACoreWrapper"
        ),
        
        // IAOverTheCounter
        .binaryTarget(
            name: "IAOverTheCounter",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/1.0.0-beta.1/IAOverTheCounter-1.0.0-beta.1.xcframework.zip",
            checksum: "0b14441459219222114faf2d5715619a5f27d9a25a84b30ffa745370f8f45b05"
        ),
        .target(
            name: "IAOverTheCounterWrapper",
            dependencies: [ 
                .target(name: "IOSKit"),
                .target(name: "IACore"),
                .target(name: "IAOverTheCounter"),
            ],
            path: "Sources/IAOverTheCounterWrapper"
        ),
        
        // IAOrdering
        .binaryTarget(
            name: "IAOrdering",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/1.0.0-beta.1/IAOrdering-1.0.0-beta.1.xcframework.zip",
            checksum: "2846e0c5dbf59bcfc3394a308593c2e3c1639e9f128d3b9c62404ebdc0ebfcaa"
        ),
        .target(
            name: "IAOrderingWrapper",
            dependencies: [ 
                .target(name: "IOSKit"),
                .target(name: "IACore"),
                .target(name: "IAOrdering"),
            ],
            path: "Sources/IAOrderingWrapper"
        ),
        
        // IAPharmacy
        .binaryTarget(
            name: "IAPharmacy",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/1.0.0-beta.1/IAPharmacy-1.0.0-beta.1.xcframework.zip",
            checksum: "9aede8994d1718e8315fa914ddb3409a98f755703b54fba51928d5e858eb0000"
        ),
        .target(
            name: "IAPharmacyWrapper",
            dependencies: [ 
                .target(name: "IOSKit"),
                .target(name: "IACore"),
                .target(name: "IAPharmacy"),
            ],
            path: "Sources/IAPharmacyWrapper"
        ),
        
        // IACardLink
        .binaryTarget(
                name: "IACardLink",
                url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/1.0.0-beta.1/IACardLink-1.0.0-beta.1.xcframework.zip",
                checksum: "085222d76906208a4d8fab3f92356021c48930887f6d6b34c963e0301bc33708"
            ),
        .target(
            name: "IACardLinkWrapper",
            dependencies: [ 
                .target(name: "IOSKit"),
                .target(name: "IACore"),
                .target(name: "IACardLink"),
                .product(name: "OpenSSL-Swift", package: "OpenSSL-Swift"),
            ],
            path: "Sources/IACardLinkWrapper"
        ),
        
        // IAIntegrations
        .binaryTarget(
            name: "IAIntegrations",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/1.0.0-beta.1/IAIntegrations-1.0.0-beta.1.xcframework.zip",
            checksum: "3aee1c98910abe4fe08f4edd3f7381b867ce9b3089ac0be972f914bc6a5f1134"
        ),
        .target(
            name: "IAIntegrationsWrapper",
            dependencies: [ 
                .target(name: "IOSKit"),
                .target(name: "IACore"),
                .target(name: "IAIntegrations"),
            ],
            path: "Sources/IAIntegrationsWrapper"
        ),
        
        // IAPrescription
        .binaryTarget(
            name: "IAPrescription",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/1.0.0-beta.1/IAPrescription-1.0.0-beta.1.xcframework.zip",
            checksum: "4405b675ba58cc2e27f81475dfa964f9ab18f46c21d2a8c9dbf436e11ee02d13"
        ),
        .target(
            name: "IAPrescriptionWrapper",
            dependencies: [ 
                .target(name: "IOSKit"),
                .target(name: "IACore"),
                .target(name: "IAPrescription"),
            ],
            path: "Sources/IAPrescriptionWrapper"
        )
    ]
)
