// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlacementSwiftUI",
    platforms: [
        // The wrapper's API floor: sizeThatFits(_:uiView:context:) and ProposedViewSize are iOS 16+.
        .iOS(.v16)
    ],
    products: [
        // Main product that users will import (mandatory)
        .library(
            name: "PlacementSwiftUI",
            targets: ["PlacementSwiftUIWrapper"]
        ),
        // Optional widget renderers, passed through from storyly-placement-ios so consumers do not
        // have to add that package as well. Each widget type must be linked for it to render; link
        // only the ones you use.
        .library(
            name: "StorylyStoryBar",
            targets: ["StorylyStoryBarWrapper"]
        ),
        .library(
            name: "StorylyBanner",
            targets: ["StorylyBannerWrapper"]
        ),
        .library(
            name: "StorylyVideoFeed",
            targets: ["StorylyVideoFeedWrapper"]
        ),
        .library(
            name: "StorylySwipeCard",
            targets: ["StorylySwipeCardWrapper"]
        ),
        .library(
            name: "StorylyCanvas",
            targets: ["StorylyCanvasWrapper"]
        )
    ],
    dependencies: [
        // The Placement SDK. Consumers get it through this package, so they only add one URL.
        .package(url: "https://github.com/Netvent/storyly-placement-ios", exact: "1.12.0")
    ],
    targets: [
        // Binary target (the actual xcframework). url and checksum are rewritten by the
        // `placement_swiftui_release` fastlane lane in storyly-placement-swiftui-sdk.
        .binaryTarget(
            name: "PlacementSwiftUI",
            url: "https://prod-storyly-media.s3-eu-west-1.amazonaws.com/placement-swiftui-sdk/1.12.0/PlacementSwiftUI.zip",
            checksum: "a"
        ),

        // A binary target carries no dependency edges of its own, so this thin target is what links
        // the SDK alongside it.
        .target(
            name: "PlacementSwiftUIWrapper",
            dependencies: [
                "PlacementSwiftUI",
                .product(name: "StorylyPlacement", package: "storyly-placement-ios")
            ],
            path: "Sources/PlacementSwiftUI"
        ),

        // Passthrough targets: no code, they only forward to the matching widget product of
        // storyly-placement-ios. SwiftPM does not offer a transitive dependency's products in a
        // consumer's link list, which is why each one needs a target and a product here.
        .target(
            name: "StorylyStoryBarWrapper",
            dependencies: [.product(name: "StorylyStoryBar", package: "storyly-placement-ios")],
            path: "Sources/StorylyStoryBar"
        ),
        .target(
            name: "StorylyBannerWrapper",
            dependencies: [.product(name: "StorylyBanner", package: "storyly-placement-ios")],
            path: "Sources/StorylyBanner"
        ),
        .target(
            name: "StorylyVideoFeedWrapper",
            dependencies: [.product(name: "StorylyVideoFeed", package: "storyly-placement-ios")],
            path: "Sources/StorylyVideoFeed"
        ),
        .target(
            name: "StorylySwipeCardWrapper",
            dependencies: [.product(name: "StorylySwipeCard", package: "storyly-placement-ios")],
            path: "Sources/StorylySwipeCard"
        ),
        .target(
            name: "StorylyCanvasWrapper",
            dependencies: [.product(name: "StorylyCanvas", package: "storyly-placement-ios")],
            path: "Sources/StorylyCanvas"
        )
    ],
    swiftLanguageVersions: [.v5]
)
