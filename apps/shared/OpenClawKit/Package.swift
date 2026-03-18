// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "LogicaKit",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
    ],
    products: [
        .library(name: "LogicaProtocol", targets: ["LogicaProtocol"]),
        .library(name: "LogicaKit", targets: ["LogicaKit"]),
        .library(name: "LogicaChatUI", targets: ["LogicaChatUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/steipete/ElevenLabsKit", exact: "0.1.0"),
        .package(url: "https://github.com/gonzalezreal/textual", exact: "0.3.1"),
    ],
    targets: [
        .target(
            name: "LogicaProtocol",
            path: "Sources/LogicaProtocol",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .target(
            name: "LogicaKit",
            dependencies: [
                "LogicaProtocol",
                .product(name: "ElevenLabsKit", package: "ElevenLabsKit"),
            ],
            path: "Sources/LogicaKit",
            resources: [
                .process("Resources"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .target(
            name: "LogicaChatUI",
            dependencies: [
                "LogicaKit",
                .product(
                    name: "Textual",
                    package: "textual",
                    condition: .when(platforms: [.macOS, .iOS])),
            ],
            path: "Sources/LogicaChatUI",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .testTarget(
            name: "LogicaKitTests",
            dependencies: ["LogicaKit", "LogicaChatUI"],
            path: "Tests/LogicaKitTests",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
                .enableExperimentalFeature("SwiftTesting"),
            ]),
    ])
