import Foundation
import BreedAPI
import FavoriteAPI

@Observable
@MainActor
public final class BreedRootViewModel {
    private let breedRepository: BreedRepository
    private let favoriteRepository: FavoriteRepository
    private(set) var breeds: [Breed] = []
    private(set) var isLoading: Bool = false

    public init(
        breedRepository: BreedRepository,
        favoriteRepository: FavoriteRepository
    ) {
        self.breedRepository = breedRepository
        self.favoriteRepository = favoriteRepository
    }

    func getBreeds() async {
        do {
            isLoading = true

            let stream = breedRepository.getAll()

            for try await breeds in stream {
                self.breeds = breeds
            }
        }
        catch {
            // TODO: Handle errors.
        }

        isLoading = false
    }

    func search(query: String) async {
        guard !query.isEmpty else {
            await getBreeds()
            return
        }

        do {
            isLoading = true
            self.breeds = try breedRepository.search(query: query)
        }
        catch {
            // TODO: Handle errors.
        }

        isLoading = false
    }

    func toggleFavorite(id: String) {
        guard
            let breed = breeds.filter({ $0.id == id }).first
        else {
            return
        }

        do {
            if breed.isFavorite {
                try favoriteRepository.delete(id: id)
            }
            else {
                try favoriteRepository.add(id: id)
            }
        }
        catch {
            // TODO: Handle errors
        }
    }
}
