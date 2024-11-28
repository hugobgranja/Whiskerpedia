import Foundation

public struct BreedDTO: Decodable {
    public struct Image: Decodable {
        public let url: String
    }

    public let id: String
    public let name: String
    public let origin: String
    public let temperament: String
    public let description: String
    public let image: Image?
}
