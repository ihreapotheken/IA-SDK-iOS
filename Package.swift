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
            )
    ],
    dependencies: [
        .package(url: "https://github.com/gematik/OpenSSL-Swift", exact: "4.3.1"),
    ],
    targets: [
        // IACore
        .binaryTarget(
            name: "IACore",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.32/IACore-0.0.32.xcframework.zip",
            checksum: "5dded341a4598067e606574bc574394977bf6aa8a436be9d8e757a67504e9523"
        ),
        
        // IAOverTheCounter
        .binaryTarget(
            name: "IAOverTheCounter",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.32/IAOverTheCounter-0.0.32.xcframework.zip",
            checksum: "504f6b17e6b9e845fd6f0c3c4d778c2698597f480f6169067a16d13d654dce90"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.32/IAOrdering-0.0.32.xcframework.zip",
            checksum: "9923d28c8d04dd731607cf76edbef8127c047793ddffee95d9a3252e339124b5"
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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.32/IAPharmacy-0.0.32.xcframework.zip",
            checksum: "605e87c1f917542e95acbc50000936e4603c694e448a4568ffe265ebc833c374"
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
                url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.32/IACardLink-0.0.32.xcframework.zip",
                checksum: "79028b26834faf9a53b3d2800c44381b6bdc98b5c4af95a7e4d72caaa02b6850"
            ),
        .target(
            name: "IACardLinkWrapper",
            dependencies: [ 
                .target(name: "IACore"),
                .target(name: "IACardLink"),
                .product(name: "OpenSSL-Swift", package: "OpenSSL-Swift"),
            ],
            path: "Sources/IACardLinkWrapper"
        )
    ]
)
