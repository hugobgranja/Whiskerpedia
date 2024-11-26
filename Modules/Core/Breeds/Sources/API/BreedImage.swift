import Foundation

public struct BreedImage: Decodable {
    public let url: String

    public init(url: String) {
        self.url = url
    }
}
