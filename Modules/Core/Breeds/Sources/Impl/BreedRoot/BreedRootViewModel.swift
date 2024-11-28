import Foundation
import BreedsAPI
import Combine

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
    private(set) var paginatedBreeds: [Breed] = []
    private(set) var searchBreeds: [Breed] = []
    private var currentPage: Int = 0
    private(set) var isNextPageAvailable: Bool = true
    private(set) var isLoading: Bool = false

    var presentationMode: PresentationMode {
        searchBreeds.isEmpty ? .list : .search
    }

    public init(
        breedRepository: BreedRepository
    ) {
        self.breedRepository = breedRepository
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
}
