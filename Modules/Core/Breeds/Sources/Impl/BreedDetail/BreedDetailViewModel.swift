import Foundation
import BreedsAPI

@MainActor
public final class BreedDetailViewModel {
    let breed: Breed
    let imageUrl: URL?

    public init(
        breed: Breed
    ) {
        self.breed = breed
        self.imageUrl = breed.image.flatMap { URL(string: $0.url) }
    }
}
