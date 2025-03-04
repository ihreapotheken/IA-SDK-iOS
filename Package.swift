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
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.2/IACore-0.0.2.xcframework.zip",
            checksum: "1d90b4892a5796dab38177b542a9e3e4ef7ffab03c7ad3c7e0e064ead85815ce"
        ),
        .binaryTarget(
            name: "IAOverTheCounter",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.2/IAOverTheCounter-0.0.2.xcframework.zip",
            checksum: "efa6d6974a2ade7e722d84f94b1477cc4da27d653133117e2f889a49a8b9e934"
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
