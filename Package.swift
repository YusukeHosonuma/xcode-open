// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XcodeOpen",
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files.git",  from: "2.0.1"),
        .package(url: "https://github.com/kareman/SwiftShell.git", from: "3.0.1"),
    ],
    targets: [
        .target(
            name: "XcodeOpen",
            dependencies: ["XcodeOpenCore"]),
        .target(
            name: "XcodeOpenCore",
            dependencies: ["Files", "SwiftShell"]),
        .testTarget(
            name: "XcodeOpenTests",
            dependencies: ["XcodeOpenCore"]),
    ]
)
