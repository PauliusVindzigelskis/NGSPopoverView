// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "NGSPopoverView",
    platforms: [.iOS(.v12)],
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
