import Foundation
import SwiftData

@Model
public final class BreedEntity {
    @Attribute(.unique) public var id: String
    public var name: String
    public var origin: String
    public var temperament: String
    public var info: String
    public var imageUrl: String?
    public var isFavorite: Bool

    public init(
        id: String,
        name: String,
        origin: String,
        temperament: String,
        info: String,
        imageUrl: String?,
        isFavorite: Bool
    ) {
        self.id = id
        self.name = name
        self.origin = origin
        self.temperament = temperament
        self.info = info
        self.imageUrl = imageUrl
        self.isFavorite = isFavorite
    }
}
