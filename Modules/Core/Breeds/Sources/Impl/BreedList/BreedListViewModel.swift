import Foundation
import BreedsAPI

@Observable
@MainActor
public final class BreedListViewModel {
    private let breedRepository: BreedRepository
    private(set) var breeds: [Breed] = []

    public init(
        breedRepository: BreedRepository
    ) {
        self.breedRepository = breedRepository
    }

    func getBreeds() async {
        do {
            self.breeds = try await breedRepository.getBreeds(limit: 10, page: 0).breeds
        }
        catch {
            // TODO: Handle errors.
        }
    }
}
