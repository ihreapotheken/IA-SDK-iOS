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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.6.0-beta.214/IOSKit-2.6.0-beta.214.xcframework.zip",
            checksum: "7af60616761aa5f8bbe2287fbf65cf711fcb64fec55099dd7c0d0c62861bba79"
        ),
        
        // IACore
        .binaryTarget(
            name: "IACore",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.6.0-beta.214/IACore-2.6.0-beta.214.xcframework.zip",
            checksum: "3177d7269f4ec661b85af3e095fee85cd9a1d9da04d840bacd6b8005d34588b0"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.6.0-beta.214/IAOverTheCounter-2.6.0-beta.214.xcframework.zip",
            checksum: "18f9f1d4df3fe8c8d3aa5f93eb2592d1d2eb5827d6ebe972e487f2442fa5a189"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.6.0-beta.214/IAOrdering-2.6.0-beta.214.xcframework.zip",
            checksum: "5662c58e23826f477f9a4b37daa1ce5e65b9a67c174d95eb9701834ae52e1b20"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.6.0-beta.214/IAPharmacy-2.6.0-beta.214.xcframework.zip",
            checksum: "75a2e5dcf58dffd3eb8b13ee75ca2a7041f76996ea653da0f15c5828a19ba965"
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
                url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.6.0-beta.214/IACardLink-2.6.0-beta.214.xcframework.zip",
                checksum: "e2ef6d96878d0c5ffba6a3be59643c4880e530a8e332371dc0621ea96d148395"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.6.0-beta.214/IAIntegrations-2.6.0-beta.214.xcframework.zip",
            checksum: "93a7814a4e2ef908afd324ae4f262470e4b6cb37557ef13fe36adc67e78bc64a"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.6.0-beta.214/IAPrescription-2.6.0-beta.214.xcframework.zip",
            checksum: "5d4bbc182235cc35a9991ddb07578f3a2257552f10831b7c8400dea1477d4b2f"
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
