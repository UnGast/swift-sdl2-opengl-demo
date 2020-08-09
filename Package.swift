// swift-tools-version:5.3
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
        .target(
            name: "Demo",
            dependencies: ["GL", "CSDL2"])
    ]
)
