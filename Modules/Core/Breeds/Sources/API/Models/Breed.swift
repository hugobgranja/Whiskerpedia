import Foundation

public struct Breed: Identifiable, Sendable, Equatable, Hashable {
    public let id: String
    public let name: String
    public let origin: String
    public let temperament: String
    public let description: String
    public let imageUrl: String?
    public let isFavorite: Bool

    public init(
        id: String,
        name: String,
        origin: String,
        temperament: String,
        description: String,
        imageUrl: String?,
        isFavorite: Bool
    ) {
        self.id = id
        self.name = name
        self.origin = origin
        self.temperament = temperament
        self.description = description
        self.imageUrl = imageUrl
        self.isFavorite = isFavorite
    }

    public static func == (lhs: Breed, rhs: Breed) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
