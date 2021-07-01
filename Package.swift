// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "XCTestKit",
    platforms: [
        .macOS(.v10_11),
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "XCTestKit",
            targets: ["XCTestKit"]
        )
    ],
    dependencies:  [
        .package(url: "git@github.com:pvieito/FoundationKit.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "XCTestKit",
            dependencies: ["FoundationKit"],
            path: "XCTestKit"
        )
    ]
)
