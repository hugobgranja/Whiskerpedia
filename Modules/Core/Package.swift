// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v18)]
)

// MARK: Breeds
package.targets.append(contentsOf: [
    .target(
        name: "BreedsAPI",
        path: "Breeds/Sources/API"
    ),
    .target(
        name: "BreedsImpl",
        dependencies: ["BreedsAPI"],
        path: "Breeds/Sources/Impl"
    ),
])

package.products.append(contentsOf: [
    .library(
        name: "BreedsAPI",
        targets: ["BreedsAPI"]
    ),
    .library(
        name: "BreedsImpl",
        targets: ["BreedsImpl"]
    )
])


// MARK: CatClient
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
