// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "XCTestKit",
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
            dependencies: ["FoudationKit"],
            path: "XCTestKit"
        )
    ]
)
