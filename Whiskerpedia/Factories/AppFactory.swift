import Foundation
import BreedAPI
import BreedImpl

@MainActor
final class AppFactory {
    private let breedRepository: BreedRepository
    private weak var breedRootViewModel: BreedRootViewModel?

    init(breedRepository: BreedRepository) {
        self.breedRepository = breedRepository
    }

    func makeBreedRootView(navDelegate: BreedNavDelegate?) -> BreedRootView {
        let viewModel = breedRootViewModel ?? BreedRootViewModel(breedRepository: breedRepository)
        self.breedRootViewModel = viewModel
        return BreedRootView(
            viewModel: viewModel,
            navDelegate: navDelegate
        )
    }

    func makeBreedDetailView(breed: Breed) -> BreedDetailView {
        return BreedDetailView(model: BreedDetailModel(breed: breed))
    }
}
