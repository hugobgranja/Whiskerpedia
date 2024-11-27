import Foundation
import BreedsAPI
import BreedsImpl

@MainActor
final class AppFactory {
    private let breedRepository: BreedRepository
    private weak var breedListViewModel: BreedListViewModel?
    private weak var breedDetailViewModel: BreedDetailViewModel?

    init(breedRepository: BreedRepository) {
        self.breedRepository = breedRepository
    }

    func makeBreedListView(navDelegate: BreedListNavDelegate?) -> BreedListView {
        let viewModel = breedListViewModel ?? BreedListViewModel(breedRepository: breedRepository)
        self.breedListViewModel = viewModel
        return BreedListView(
            viewModel: viewModel,
            navDelegate: navDelegate
        )
    }

    func makeBreedDetailView(breed: Breed) -> BreedDetailView {
        let viewModel = breedDetailViewModel ?? BreedDetailViewModel(breed: breed)
        self.breedDetailViewModel = viewModel
        return BreedDetailView(viewModel: viewModel)
    }
}
