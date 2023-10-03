// swift-tools-version: 5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NGSPopoverView",
    platforms: [.iOS(.v7)],
    products: [
        .library(
            name: "NGSPopoverView",
            targets: ["NGSPopoverView"]),
    ],
    targets: [
        .target(
            name: "NGSPopoverView",
            path: "Pod/Classes",
            publicHeadersPath: ""
	),
    ]
)
