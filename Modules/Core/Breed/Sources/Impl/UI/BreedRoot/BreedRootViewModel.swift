import Foundation
import BreedAPI
import FavoriteAPI

@Observable
@MainActor
public final class BreedRootViewModel {
    enum Constants {
        static let paginationLimit = 20
    }

    enum PresentationMode {
        case list
        case search
    }

    private let breedRepository: BreedRepository
    private let favoriteRepository: FavoriteRepository
    private(set) var paginatedBreeds: [Breed] = []
    private(set) var searchBreeds: [Breed] = []
    private var currentPage: Int = 0
    private(set) var isNextPageAvailable: Bool = true
    private(set) var isLoading: Bool = false

    var presentationMode: PresentationMode {
        searchBreeds.isEmpty ? .list : .search
    }

    public init(
        breedRepository: BreedRepository,
        favoriteRepository: FavoriteRepository
    ) {
        self.breedRepository = breedRepository
        self.favoriteRepository = favoriteRepository
    }

    func getPage() async {
        guard isNextPageAvailable else { return }

        isLoading = true

        do {
            let response = try await breedRepository.get(
                limit: Constants.paginationLimit,
                page: currentPage
            )

            currentPage += 1

            if paginatedBreeds.count >= response.totalItemCount {
                isNextPageAvailable = false
            }

            self.paginatedBreeds += response.breeds
        }
        catch {
            // TODO: Handle errors.
        }

        isLoading = false
    }

    func search(query: String) async {
        guard !query.isEmpty else {
            searchBreeds = []
            return
        }

        isLoading = true

        do {
            self.searchBreeds = try await breedRepository.search(query: query)
        }
        catch {
            // TODO: Handle errors.
        }

        isLoading = false
    }

    func toggleFavorite(id: String) async {
        do {
            guard let breed = try await breedRepository.get(id: id) else { return }

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

    func refreshPaginatedBreeds() async {
        do {
            self.paginatedBreeds = try await breedRepository.getAll()
        }
        catch {
            // TODO: Handle errors
        }
    }

    func refreshSearchBreeds() async {
        do {
            let ids = searchBreeds.map { $0.id }
            self.searchBreeds = try await breedRepository.get(ids: ids)
        }
        catch {
            // TODO: Handle errors
        }
    }
}
