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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.0.0-beta.10/IOSKit-2.0.0-beta.10.xcframework.zip",
            checksum: "434a5f08785bb87477b3b9a953141c9a890f4c533f93826f374d56d105b16d32"
        ),
        
        // IACore
        .binaryTarget(
            name: "IACore",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.0.0-beta.10/IACore-2.0.0-beta.10.xcframework.zip",
            checksum: "e3b92e3db01e43ba9844171e0a3736c1b6a486dc6771f613cdfe94e0d266ab7f"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.0.0-beta.10/IAOverTheCounter-2.0.0-beta.10.xcframework.zip",
            checksum: "2d0c248a3d79e2ecc666b9ccbeee88c2f0b42c0634c1069c4c258754597c19b4"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.0.0-beta.10/IAOrdering-2.0.0-beta.10.xcframework.zip",
            checksum: "82efe23dd16f3be1b969eaa063007c8f7d4e966225caec204887e7ad4b36cf9e"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.0.0-beta.10/IAPharmacy-2.0.0-beta.10.xcframework.zip",
            checksum: "d2a45ed5e35bec02c65f2e054ed0d84ac8a4e699f514b7e8bfa1205b537682da"
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
                url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.0.0-beta.10/IACardLink-2.0.0-beta.10.xcframework.zip",
                checksum: "8ac47573b6ebce5c32e327bae7f760fd4bdb3cfe5b7e9349a159495205916819"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.0.0-beta.10/IAIntegrations-2.0.0-beta.10.xcframework.zip",
            checksum: "9afbab12df7d013cdbf8677cfeb8c7268a65a6d9a0e007f4f50c434dab8d233f"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.0.0-beta.10/IAPrescription-2.0.0-beta.10.xcframework.zip",
            checksum: "9b00f0da0cd12e9807f2125d5dc15f5988b023b26015080c7275e2807ce8d6de"
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
