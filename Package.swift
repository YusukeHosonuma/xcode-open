// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XcodeOpen",
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files.git",  from: "4.1.1"),
        .package(url: "https://github.com/kareman/SwiftShell.git", from: "5.0.1"),
        .package(url: "https://github.com/kylef/Commander.git",    from: "0.9.1"),
    ],
    targets: [
        .target(
            name: "XcodeOpen",
            dependencies: ["XcodeOpenCore"]),
        .target(
            name: "XcodeOpenCore",
            dependencies: ["Files", "SwiftShell", "Commander"]),
        .testTarget(
            name: "XcodeOpenTests",
            dependencies: ["XcodeOpenCore"]),
    ]
)
