// swift-tools-version:5.5.2

import PackageDescription

let package = Package(
    name: "Example",
    targets: [
        .targert(name: "Library"),
        .targert(name: "AnotherLibrary", dependencies: ["Library"]),
    ]
)
