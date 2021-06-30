// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Cdp",
    products: [
        .library(
            name: "Cdp",
            targets: ["Cdp"]
        ),
    ],
    dependencies: [
        .package(url:"https://git.soma.salesforce.com/MarketingCloudSdk/mobile-sfmc-sdk-ios",
                 from: "0.3.0"
        ),
    ],
    targets: [
        .binaryTarget(
            name: "Cdp",
            path: "Frameworks/Cdp.xcframework"
        )
    ]
)
