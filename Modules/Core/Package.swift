// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v18)]
)

// MARK: CatClientAPI
package.targets.append(contentsOf: [
    .target(
        name: "CatClientAPI",
        path: "CatClient/Sources/API"
    ),
    .target(
        name: "CatClientImpl",
        dependencies: ["CatClientAPI"],
        path: "CatClient/Sources/Impl"
    ),
    .target(
        name: "CatClientMocks",
        dependencies: ["CatClientAPI"],
        path: "CatClient/Mocks"
    ),
    .testTarget(
        name: "CatClientTests",
        dependencies: [
            "CatClientAPI",
            "CatClientImpl",
            "CatClientMocks"
        ],
        path: "CatClient/Tests"
    )
])

package.products.append(contentsOf: [
    .library(
        name: "CatClientAPI",
        targets: ["CatClientAPI"]
    ),
    .library(
        name: "CatClientImpl",
        targets: ["CatClientImpl"]
    )
])
