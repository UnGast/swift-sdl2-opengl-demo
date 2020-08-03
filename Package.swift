// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-sdl2-opengl",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "swift-sdl2-opengl",
            targets: ["swift-sdl2-opengl"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kelvin13/swift-opengl.git", .branch("master")),
        .package(url: "https://github.com/PureSwift/SDL", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "swift-sdl2-opengl",
            dependencies: []),
        .testTarget(
            name: "swift-sdl2-openglTests",
            dependencies: ["swift-sdl2-opengl"]),
    ]
)
