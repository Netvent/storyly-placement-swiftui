// The shipped code lives in the PlacementSwiftUI xcframework declared in Package.swift.
// SwiftPM requires a target to have sources, so this file exists to let the product carry
// dependency edges to the binary target and to the Placement SDK. Do not add API here.
struct Storyly {
    var text = "Hello, World!"
}
