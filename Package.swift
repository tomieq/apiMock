// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "Mock",
    dependencies: [
        .package(url: "https://github.com/tomieq/swifter.git", .upToNextMajor(from: "1.5.5"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Mock",
            dependencies: ["Swifter"])
    ]
)
