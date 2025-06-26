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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.11.10-beta/IACore-0.11.10-beta.xcframework.zip",
            checksum: "1ce58d315a0e8c827c9ac3072bb12f7cb2c9024cb65daa57d0d111d474eff363"
        ),
        
        // IAOverTheCounter
        .binaryTarget(
            name: "IAOverTheCounter",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.11.10-beta/IAOverTheCounter-0.11.10-beta.xcframework.zip",
            checksum: "6e63df73d685ed946316bd9a8bf6cd7ee6582db39e24aa7323f67b8c3f85ae97"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.11.10-beta/IAOrdering-0.11.10-beta.xcframework.zip",
            checksum: "917fc24b71518499aa2cd6b26d10b25637028d7bb4a0231d22d9cca7d4f2596d"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.11.10-beta/IAPharmacy-0.11.10-beta.xcframework.zip",
            checksum: "bb5e26a81c35fd70f15cf7e69f397c53c585831c9640c25c6615e6e8f9bb87fa"
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
                url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.11.10-beta/IACardLink-0.11.10-beta.xcframework.zip",
                checksum: "bb9ace1f2738e4692586b86ffa3c5a2d3b2e471853d047432e169d059bba145f"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.11.10-beta/IAIntegrations-0.11.10-beta.xcframework.zip",
            checksum: "daf801b0c38f2f6143d8ab20cde641945ab2ff997cb95420904cb05fdd10ae86"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.11.10-beta/IAPrescription-0.11.10-beta.xcframework.zip",
            checksum: "d15e222bd1287175c227d480d30b4c0f1db28d78d95ecbc49bc9fcf55d4033d4"
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
