// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "Cdp",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12),        // Minimum iOS 12
    ],
    products: [
        .library(name: "Cdp", targets: ["CdpWrapper"])
    ],
    dependencies: [
        .package(url: "https://github.com/salesforce-marketingcloud/sfmc-sdk-ios", from: "3.0.0"),
    ],
    targets: [
        .binaryTarget(
            name: "Cdp",
            path: "Frameworks/Cdp.xcframework"
        ),
        .target(
            name: "CdpWrapper",
            dependencies: [
                .target(name: "Cdp"),
                .product(name: "SFMCSDK", package: "sfmc-sdk-ios")
            ],
            path: "CdpWrapper"
        )
    ]
)