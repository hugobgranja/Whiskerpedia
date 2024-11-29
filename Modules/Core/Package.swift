// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v18)],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.0.0")
    ]
)

// MARK: Breed
package.targets.append(contentsOf: [
    .target(
        name: "BreedAPI",
        path: "Breed/Sources/API"
    ),
    .target(
        name: "BreedImpl",
        dependencies: [
            "BreedAPI",
            "BreedMocks",
            "CatClientAPI",
            "DatabaseAPI",
            "FavoriteAPI",
            "FavoriteMocks",
            "Kingfisher",
        ],
        path: "Breed/Sources/Impl"
    ),
    .target(
        name: "BreedMocks",
        dependencies: ["BreedAPI"],
        path: "Breed/Mocks"
    ),
])

package.products.append(contentsOf: [
    .library(
        name: "BreedAPI",
        targets: ["BreedAPI"]
    ),
    .library(
        name: "BreedImpl",
        targets: ["BreedImpl"]
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

// MARK: Favorite
package.targets.append(contentsOf: [
    .target(
        name: "FavoriteAPI",
        path: "Favorite/Sources/API"
    ),
    .target(
        name: "FavoriteImpl",
        dependencies: [
            "DatabaseAPI",
            "FavoriteAPI"
        ],
        path: "Favorite/Sources/Impl"
    ),
    .target(
        name: "FavoriteMocks",
        dependencies: ["FavoriteAPI"],
        path: "Favorite/Mocks"
    )
])

package.products.append(contentsOf: [
    .library(
        name: "FavoriteAPI",
        targets: ["FavoriteAPI"]
    ),
    .library(
        name: "FavoriteImpl",
        targets: ["FavoriteImpl"]
    )
])
