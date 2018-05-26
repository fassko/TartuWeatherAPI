// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "TartuWeatherAPI",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup", from: "1.7.1"),
    ],
    targets: [
        .target(name: "App", dependencies: ["SwiftSoup", "Vapor"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
