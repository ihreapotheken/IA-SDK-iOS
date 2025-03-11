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
            name: "IACore",
            targets: ["IACore"]),
        .library(
            name: "IAOverTheCounter",
            targets: ["IAOverTheCounterWrapper"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "IACore",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.6/IACore-0.0.6.xcframework.zip",
            checksum: "c8f3951e2e28ab25c9e3b27a61fd40a844e443501fd4f9379246770cacbd8ff2"
        ),
        .binaryTarget(
            name: "IAOverTheCounter",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.6/IAOverTheCounter-0.0.6.xcframework.zip",
            checksum: "49f768b13062187ce8fb18451ce8c6e7bcba53d28a0528428afa778482f335a5"
        ),
        .target(
            name: "IAOverTheCounterWrapper",
            dependencies: [ 
                .target(name: "IACore"),
                .target(name: "IAOverTheCounter"),
            ],
            path: "Sources"
        )
    ]
)
