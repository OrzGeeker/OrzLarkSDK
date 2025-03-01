// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OrzLarkSDK",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v6),
        .visionOS(.v1),
        .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "Message",
            targets: ["Message"]
        ),
        .library(
            name: "LarkOpenAPI", 
            targets: ["OpenAPI"]
        ),
    ],
    dependencies: [
      .package(url: "https://github.com/apple/swift-openapi-generator.git", from: "1.7.0"),
      .package(url: "https://github.com/apple/swift-openapi-runtime.git", from: "1.8.0"),
      .package(url: "https://github.com/apple/swift-openapi-urlsession.git", from: "1.0.2"),
//      .package(url: "https://github.com/swiftlang/swift-testing.git", from: "6.0.3"),
    ],
    targets: [
        .target(name: "Message"),
        .testTarget(
            name: "MessageTests",
            dependencies: ["Message"]
        ),
        .target(name: "Bot"),
        .target(
            name: "OpenAPI", 
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession")
            ],
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
            ]
        ),
        .testTarget(
            name: "OpenAPITests", 
            dependencies: [
                "OpenAPI",
//                .product(name: "Testing", package: "swift-testing")
            ]
        )
    ]
)
