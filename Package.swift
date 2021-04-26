// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let name = "AccessibilitySnapshotColorBlindness"
let tests = name + "Tests"

let package = Package(
    name: name,
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(
            name: name,
            targets: [name]
        ),
    ],
    dependencies: [
        .package(
            name: "SnapshotTesting",
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.8.2"
        ),
    ],
    targets: [
        .target(
            name: name,
            dependencies: [
                .product(name: "SnapshotTesting", package: "SnapshotTesting"),
            ],
            path: "Sources"
        ),
        .testTarget(
            name: tests,
            dependencies: [
                .target(name: name),
            ],
            path: "Tests",
            exclude: [
                "__Snapshots__",
                "example.png",
            ]
        ),
    ]
)
