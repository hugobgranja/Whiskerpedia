import Foundation

public struct Breed: Identifiable, Decodable, Sendable {
    public let id: String
    public let name: String
    public let origin: String
    public let temperament: String
    public let description: String
    public let image: BreedImage?

    public init(
        id: String,
        name: String,
        origin: String,
        temperament: String,
        description: String,
        image: BreedImage?
    ) {
        self.id = id
        self.name = name
        self.origin = origin
        self.temperament = temperament
        self.description = description
        self.image = image
    }
}
