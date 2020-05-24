// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "XCTestKit",
    platforms: [
        .macOS(.v10_11)
    ],
    products: [
        .library(
            name: "XCTestKit",
            targets: ["XCTestKit"]
        )
    ],
    dependencies:  [
        .package(path: "../FoundationKit"),
    ],
    targets: [
        .target(
            name: "XCTestKit",
            dependencies: ["FoundationKit"],
            path: "XCTestKit"
        )
    ]
)
