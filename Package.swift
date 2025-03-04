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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.3/IACore-0.0.3.xcframework.zip",
            checksum: "e39b34784a634aacd9a3ba593350dd9e476b1716637efb80c0d0c81a7719f7a5"
        ),
        .binaryTarget(
            name: "IAOverTheCounter",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.3/IAOverTheCounter-0.0.3.xcframework.zip",
            checksum: "053b4c2e666281d212cf0ec6315116b659d451afffe73895a7a50e7019a99639"
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
