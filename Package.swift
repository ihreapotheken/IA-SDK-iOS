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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.5/IACore-0.0.5.xcframework.zip",
            checksum: "f4cb3f9e729bde3f5e6ad39bba8a13d923ebf16eced6671abd556b3d63dbddc7"
        ),
        .binaryTarget(
            name: "IAOverTheCounter",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.5/IAOverTheCounter-0.0.5.xcframework.zip",
            checksum: "3845d47636a70d756cd1b88851e7d1b76cf39c1c6a051cbbcf4481f0126ba668"
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
