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
        // IACore
        .binaryTarget(
            name: "IACore",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.11.7-beta/IACore-0.11.7-beta.xcframework.zip",
            checksum: "75abf559fce6c8f797293e9b43af04369b8dc0eacbf0e9a80c656bce9894afe8"
        ),
        
        // IAOverTheCounter
        .binaryTarget(
            name: "IAOverTheCounter",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.11.7-beta/IAOverTheCounter-0.11.7-beta.xcframework.zip",
            checksum: "1273ab6f18be335d6268b37ea5000947078e6453bc5204269e657bf650a7fde8"
        ),
        .target(
            name: "IAOverTheCounterWrapper",
            dependencies: [ 
                .target(name: "IACore"),
                .target(name: "IAOverTheCounter"),
            ],
            path: "Sources/IAOverTheCounterWrapper"
        ),
        
        // IAOrdering
        .binaryTarget(
            name: "IAOrdering",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.11.7-beta/IAOrdering-0.11.7-beta.xcframework.zip",
            checksum: "6b5a937527c44c189656eb93fa12c74861bbae2600ac4cfb89870a46abe04c3d"
        ),
        .target(
            name: "IAOrderingWrapper",
            dependencies: [ 
                .target(name: "IACore"),
                .target(name: "IAOrdering"),
            ],
            path: "Sources/IAOrderingWrapper"
        ),
        
        // IAPharmacy
        .binaryTarget(
            name: "IAPharmacy",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.11.7-beta/IAPharmacy-0.11.7-beta.xcframework.zip",
            checksum: "2aab531dfeb4e8f9cfd27487c962c753669ad7104052ada017a891f6ae21d37c"
        ),
        .target(
            name: "IAPharmacyWrapper",
            dependencies: [ 
                .target(name: "IACore"),
                .target(name: "IAPharmacy"),
            ],
            path: "Sources/IAPharmacyWrapper"
        ),
        
        // IACardLink
        .binaryTarget(
                name: "IACardLink",
                url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.11.7-beta/IACardLink-0.11.7-beta.xcframework.zip",
                checksum: "eb2e189796dd6f2de1ccc3edef6b1ffbfa7b3e0a5417e3be325f28647456195d"
            ),
        .target(
            name: "IACardLinkWrapper",
            dependencies: [ 
                .target(name: "IACore"),
                .target(name: "IACardLink"),
                .product(name: "OpenSSL-Swift", package: "OpenSSL-Swift"),
            ],
            path: "Sources/IACardLinkWrapper"
        ),
        
        // IAIntegrations
        .binaryTarget(
            name: "IAIntegrations",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.11.7-beta/IAIntegrations-0.11.7-beta.xcframework.zip",
            checksum: "18ff74f8631dc4454157470508594e17c2508b9207392eeaedaa6078b8c3145b"
        ),
        .target(
            name: "IAIntegrationsWrapper",
            dependencies: [ 
                .target(name: "IACore"),
                .target(name: "IAIntegrations"),
            ],
            path: "Sources/IAIntegrationsWrapper"
        ),
        
        // IAPrescription
        .binaryTarget(
            name: "IAPrescription",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.11.7-beta/IAPrescription-0.11.7-beta.xcframework.zip",
            checksum: "c50cae9647ec553314a1e7b24a689d3666888b585962bc2a5571c2e510a252bc"
        ),
        .target(
            name: "IAPrescriptionWrapper",
            dependencies: [ 
                .target(name: "IACore"),
                .target(name: "IAPrescription"),
            ],
            path: "Sources/IAPrescriptionWrapper"
        )
    ]
)
