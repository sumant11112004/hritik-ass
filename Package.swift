// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "AnimeExplorer",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .executable(name: "AnimeExplorerApp", targets: ["AnimeExplorerApp"]),
    ],
    targets: [
        .target(
            name: "AnimeExplorerApp",
            dependencies: []
        ),
        .testTarget(name: "AnimeExplorerAppTests", dependencies: ["AnimeExplorerApp"]),
    ]
)
