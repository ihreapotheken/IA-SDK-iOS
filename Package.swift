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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.19.2-beta/IOSKit-0.19.2-beta.xcframework.zip",
            checksum: "03c5b3c052137e5076be0a03406310d711a01a037b52acbfdc137fdfc20f4dd3"
        ),
        
        // IACore
        .binaryTarget(
            name: "IACore",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.19.2-beta/IACore-0.19.2-beta.xcframework.zip",
            checksum: "9ea54e6654090efcb890fb7133019da9ce1e6eaee21a1d64d501656bf5abba43"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.19.2-beta/IAOverTheCounter-0.19.2-beta.xcframework.zip",
            checksum: "abfe53f5d3aeed865a6b3d1c8255dd07252271d7bb1702256fd757f61aaf6738"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.19.2-beta/IAOrdering-0.19.2-beta.xcframework.zip",
            checksum: "3877f53cf2e460d09ca2e29ff99cfe5c0acade70dd02dc1b444f5e0fea291d25"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.19.2-beta/IAPharmacy-0.19.2-beta.xcframework.zip",
            checksum: "cc15967110a462559c4100eb5ad868f57c555131a269a32dde270dcbcd723bda"
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
                url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.19.2-beta/IACardLink-0.19.2-beta.xcframework.zip",
                checksum: "5d480a44d34a050b10c30b0a39fbd287b501c70620d8f130d09cd7e001022189"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.19.2-beta/IAIntegrations-0.19.2-beta.xcframework.zip",
            checksum: "0942c0229799646eb470272b41d2b49d4a995626d3a4206dbe21bb0f6b75e6a4"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.19.2-beta/IAPrescription-0.19.2-beta.xcframework.zip",
            checksum: "d10f212a640dc5c3183b382f67d88dfb78a9ee06461acaa6b5103e5a1b0bd187"
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
