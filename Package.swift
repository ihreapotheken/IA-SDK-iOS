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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.7.0-beta.226/IOSKit-2.7.0-beta.226.xcframework.zip",
            checksum: "bcafc84a459f32fabf1d884139d52701f42c4bb31d3b91b22458c82b999a8e8f"
        ),
        
        // IACore
        .binaryTarget(
            name: "IACore",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.7.0-beta.226/IACore-2.7.0-beta.226.xcframework.zip",
            checksum: "054f1791c9e68ee28ee38b4fa114551fb626d1e9b14866f2ac5ae9c378b0a7e5"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.7.0-beta.226/IAOverTheCounter-2.7.0-beta.226.xcframework.zip",
            checksum: "042071d76b13471cc2d7ca85fec59232c7fbb54d0df91bc2159d830d0546d66e"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.7.0-beta.226/IAOrdering-2.7.0-beta.226.xcframework.zip",
            checksum: "9575e6451d5ca385c88ee947bdbd41595b9f943247d71f9c9040975501f4b308"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.7.0-beta.226/IAPharmacy-2.7.0-beta.226.xcframework.zip",
            checksum: "0c57b138518a82bf94f09b7e91db24c89ad19f446221d507fcb68df58bf63f4a"
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
                url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.7.0-beta.226/IACardLink-2.7.0-beta.226.xcframework.zip",
                checksum: "3cfd1c7dd8601c96a7c1c72a2799e95d9c5f15f993c126a7f49f22f7710b27e2"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.7.0-beta.226/IAIntegrations-2.7.0-beta.226.xcframework.zip",
            checksum: "cefeb777b92429da36226c69f79ff2a5be26809e2b2723f66f54a6c3ab074c43"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.7.0-beta.226/IAPrescription-2.7.0-beta.226.xcframework.zip",
            checksum: "f8672d2bca237f14cac7628af3d98c37fcbf59eb858f90a72b910ae5ca85d1d9"
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
