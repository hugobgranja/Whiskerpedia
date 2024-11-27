import Foundation
import BreedsAPI

public struct BreedDetailModel {
    let breed: Breed
    let imageUrl: URL?

    public init(
        breed: Breed
    ) {
        self.breed = breed
        self.imageUrl = breed.image.flatMap { URL(string: $0.url) }
    }
}
