// swift-tools-version: 6.2
// Package manifest for the Logica macOS companion (menu bar app + IPC library).

import PackageDescription

let package = Package(
    name: "Logica",
    platforms: [
        .macOS(.v15),
    ],
    products: [
        .library(name: "LogicaIPC", targets: ["LogicaIPC"]),
        .library(name: "LogicaDiscovery", targets: ["LogicaDiscovery"]),
        .executable(name: "Logica", targets: ["Logica"]),
        .executable(name: "logica-mac", targets: ["LogicaMacCLI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/orchetect/MenuBarExtraAccess", exact: "1.2.2"),
        .package(url: "https://github.com/swiftlang/swift-subprocess.git", from: "0.1.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.8.0"),
        .package(url: "https://github.com/sparkle-project/Sparkle", from: "2.8.1"),
        .package(url: "https://github.com/steipete/Peekaboo.git", branch: "main"),
        .package(path: "../shared/LogicaKit"),
        .package(path: "../../Swabble"),
    ],
    targets: [
        .target(
            name: "LogicaIPC",
            dependencies: [],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .target(
            name: "LogicaDiscovery",
            dependencies: [
                .product(name: "LogicaKit", package: "LogicaKit"),
            ],
            path: "Sources/LogicaDiscovery",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .executableTarget(
            name: "Logica",
            dependencies: [
                "LogicaIPC",
                "LogicaDiscovery",
                .product(name: "LogicaKit", package: "LogicaKit"),
                .product(name: "LogicaChatUI", package: "LogicaKit"),
                .product(name: "LogicaProtocol", package: "LogicaKit"),
                .product(name: "SwabbleKit", package: "swabble"),
                .product(name: "MenuBarExtraAccess", package: "MenuBarExtraAccess"),
                .product(name: "Subprocess", package: "swift-subprocess"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Sparkle", package: "Sparkle"),
                .product(name: "PeekabooBridge", package: "Peekaboo"),
                .product(name: "PeekabooAutomationKit", package: "Peekaboo"),
            ],
            exclude: [
                "Resources/Info.plist",
            ],
            resources: [
                .copy("Resources/Logica.icns"),
                .copy("Resources/DeviceModels"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .executableTarget(
            name: "LogicaMacCLI",
            dependencies: [
                "LogicaDiscovery",
                .product(name: "LogicaKit", package: "LogicaKit"),
                .product(name: "LogicaProtocol", package: "LogicaKit"),
            ],
            path: "Sources/LogicaMacCLI",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .testTarget(
            name: "LogicaIPCTests",
            dependencies: [
                "LogicaIPC",
                "Logica",
                "LogicaDiscovery",
                .product(name: "LogicaProtocol", package: "LogicaKit"),
                .product(name: "SwabbleKit", package: "swabble"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
                .enableExperimentalFeature("SwiftTesting"),
            ]),
    ])
