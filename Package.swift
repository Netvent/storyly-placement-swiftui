// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StorylyPlacementSwiftUI",
    platforms: [
        // The wrapper's API floor: sizeThatFits(_:uiView:context:) and ProposedViewSize are iOS 16+.
        .iOS(.v16)
    ],
    products: [
        // Main product that users will import (mandatory). Named to match the pod and the widget
        // products below — every product in this package carries the `Storyly` prefix and the
        // `SwiftUI` suffix.
        .library(
            name: "StorylyPlacementSwiftUI",
            targets: ["StorylyPlacementSwiftUIWrapper"]
        ),
        // Optional widget renderers, passed through from storyly-placement-ios so consumers do not
        // have to add that package as well. Each widget type must be linked for it to render; link
        // only the ones you use. The `SwiftUI` suffix is required: SwiftPM/Xcode cannot have two
        // products with the same name in one dependency graph, and the unsuffixed names are taken
        // by storyly-placement-ios itself, which is always in the graph through this package.
        .library(
            name: "StorylyStoryBarSwiftUI",
            targets: ["StorylyStoryBarPassthrough"]
        ),
        .library(
            name: "StorylyBannerSwiftUI",
            targets: ["StorylyBannerPassthrough"]
        ),
        .library(
            name: "StorylyVideoFeedSwiftUI",
            targets: ["StorylyVideoFeedPassthrough"]
        ),
        .library(
            name: "StorylySwipeCardSwiftUI",
            targets: ["StorylySwipeCardPassthrough"]
        ),
        .library(
            name: "StorylyCanvasSwiftUI",
            targets: ["StorylyCanvasPassthrough"]
        )
    ],
    dependencies: [
        // The Placement SDK. Consumers get it through this package, so they only add one URL.
        .package(url: "https://github.com/Netvent/storyly-placement-ios", exact: "1.13.0")
    ],
    targets: [
        // Binary target (the actual xcframework). url and checksum are rewritten by the
        // `placement_swiftui_release` fastlane lane in storyly-placement-swiftui-sdk.
        .binaryTarget(
            name: "StorylyPlacementSwiftUI",
            url: "https://prod-storyly-media.s3-eu-west-1.amazonaws.com/placement-swiftui-sdk/1.13.0/StorylyPlacementSwiftUI.zip",
            checksum: "2cd582faf1b198b1c65c6111eaf8d01a138e353fa87540eb14abed65ecda5ae4"
        ),

        // A binary target carries no dependency edges of its own, so this thin target is what links
        // the SDK alongside it.
        .target(
            name: "StorylyPlacementSwiftUIWrapper",
            dependencies: [
                "StorylyPlacementSwiftUI",
                .product(name: "StorylyPlacement", package: "storyly-placement-ios")
            ],
            path: "Sources/StorylyPlacementSwiftUI"
        ),

        // Passthrough targets: no code, they only forward to the matching widget product of
        // storyly-placement-ios. SwiftPM does not offer a transitive dependency's products in a
        // consumer's link list, which is why each one needs a target and a product here.
        .target(
            name: "StorylyStoryBarPassthrough",
            dependencies: [.product(name: "StorylyStoryBar", package: "storyly-placement-ios")],
            path: "Sources/StorylyStoryBar"
        ),
        .target(
            name: "StorylyBannerPassthrough",
            dependencies: [.product(name: "StorylyBanner", package: "storyly-placement-ios")],
            path: "Sources/StorylyBanner"
        ),
        .target(
            name: "StorylyVideoFeedPassthrough",
            dependencies: [.product(name: "StorylyVideoFeed", package: "storyly-placement-ios")],
            path: "Sources/StorylyVideoFeed"
        ),
        .target(
            name: "StorylySwipeCardPassthrough",
            dependencies: [.product(name: "StorylySwipeCard", package: "storyly-placement-ios")],
            path: "Sources/StorylySwipeCard"
        ),
        .target(
            name: "StorylyCanvasPassthrough",
            dependencies: [.product(name: "StorylyCanvas", package: "storyly-placement-ios")],
            path: "Sources/StorylyCanvas"
        )
    ],
    swiftLanguageVersions: [.v5]
)
