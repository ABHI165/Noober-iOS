// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Noober",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Noober",
            targets: ["Noober"]),
    ],
    targets: [
        .target(
            name: "Noober")
    ]
)
