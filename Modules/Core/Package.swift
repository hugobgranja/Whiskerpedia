// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v18)],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.0.0")
    ]
)

// MARK: Breeds
package.targets.append(contentsOf: [
    .target(
        name: "BreedsAPI",
        path: "Breeds/Sources/API"
    ),
    .target(
        name: "BreedsImpl",
        dependencies: [
            "BreedsAPI",
            "BreedsMocks",
            "CatClientAPI",
            "Kingfisher"
        ],
        path: "Breeds/Sources/Impl"
    ),
    .target(
        name: "BreedsMocks",
        dependencies: ["BreedsAPI"],
        path: "Breeds/Mocks"
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

// MARK: Database
package.targets.append(contentsOf: [
    .target(
        name: "DatabaseAPI",
        path: "Database/Sources/API"
    ),
    .target(
        name: "DatabaseImpl",
        dependencies: [
            "DatabaseAPI"
        ],
        path: "Database/Sources/Impl"
    ),
    .testTarget(
        name: "DatabaseTests",
        dependencies: [
            "DatabaseAPI",
            "DatabaseImpl"
        ],
        path: "Database/Tests"
    )
])

package.products.append(contentsOf: [
    .library(
        name: "DatabaseAPI",
        targets: ["DatabaseAPI"]
    ),
    .library(
        name: "DatabaseImpl",
        targets: ["DatabaseImpl"]
    )
])
