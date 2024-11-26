import Foundation

public struct BreedsPage {
    public let breeds: [Breed]
    public let totalItemCount: Int

    public init(breeds: [Breed], totalItemCount: Int) {
        self.breeds = breeds
        self.totalItemCount = totalItemCount
    }
}
