// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
// Xcode's Swift Package Manager integration does not support a single target
// mixing Swift and C-family sources, so the plugin is split into a native
// (ObjC) target and a pure-Swift target. The native target is named to match
// the package ("screen_corners") because Flutter's generated plugin
// registrant imports the module by that name and expects to find the
// registrant class (ScreenCornersPlugin) there directly.

import PackageDescription

let package = Package(
    name: "screen_corners",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "screen-corners", targets: ["screen_corners", "screen_corners_swift"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "screen_corners_swift",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        ),
        .target(
            name: "screen_corners",
            dependencies: [
                "screen_corners_swift",
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            publicHeadersPath: "include"
        )
    ]
)
