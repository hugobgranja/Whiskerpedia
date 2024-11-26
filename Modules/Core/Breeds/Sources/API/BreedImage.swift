import Foundation

public struct BreedImage: Decodable, Sendable {
    public let url: String

    public init(url: String) {
        self.url = url
    }
}
