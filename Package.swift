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
        .package(url:"https://github.com/salesforce-marketingcloud/sfmc-sdk-ios",
                 from: "2.0.0"
        ),
    ],
    targets: [
        .binaryTarget(
            name: "Cdp",
            path: "Frameworks/Cdp.xcframework"
        )
    ]
)
