// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlfredWorkflowScriptFilter",
    platforms: [.macOS(.v10_9)],
    products: [
        .library(
            name: "AlfredWorkflowScriptFilter",
            targets: ["AlfredWorkflowScriptFilter"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AlfredWorkflowScriptFilter",
            dependencies: []
        ),
        .testTarget(
            name: "AlfredWorkflowScriptFilterTests",
            dependencies: ["AlfredWorkflowScriptFilter"]
        ),
    ]
)
