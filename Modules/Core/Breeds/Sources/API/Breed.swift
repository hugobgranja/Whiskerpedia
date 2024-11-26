import Foundation

public struct Breed: Decodable {
    public let name: String
    public let origin: String
    public let temperament: String
    public let description: String
    public let image: BreedImage?
}
