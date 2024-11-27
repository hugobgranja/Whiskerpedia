import Foundation
import BreedsAPI

@Observable
@MainActor
public final class BreedRootViewModel {
    private let breedRepository: BreedRepository
    private var paginatedBreeds: [Breed] = []
    private var searchBreeds: [Breed] = []

    var breeds: [Breed] {
        query.isEmpty ? paginatedBreeds : searchBreeds
    }

    var query: String = ""

    public init(
        breedRepository: BreedRepository
    ) {
        self.breedRepository = breedRepository
    }

    func getBreeds() async {
        do {
            self.paginatedBreeds = try await breedRepository.get(limit: 10, page: 0).breeds
        }
        catch {
            // TODO: Handle errors.
        }
    }

    func search() async {
        guard !query.isEmpty else {
            searchBreeds = []
            return
        }

        do {
            self.searchBreeds = try await breedRepository.search(query: query)
        }
        catch {
            // TODO: Handle errors.
        }
    }
}
