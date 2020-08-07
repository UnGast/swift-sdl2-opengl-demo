// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-sdl2-opengl-demo",
    products: [
        .executable(
            name: "Demo",
            targets: ["Demo"]),
    ],
    dependencies: [
        .package(name: "GL", url: "https://github.com/kelvin13/swift-opengl.git", .branch("master")),
        .package(url: "https://github.com/UnGast/CSDL2", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Demo",
            dependencies: ["GL", "CSDL2"])
    ]
)
