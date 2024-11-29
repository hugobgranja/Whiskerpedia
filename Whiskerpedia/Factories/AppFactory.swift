import Foundation
import BreedAPI
import BreedImpl
import FavoriteAPI

@MainActor
final class AppFactory {
    private let breedRepository: BreedRepository
    private let favoriteRepository: FavoriteRepository
    private weak var breedRootViewModel: BreedRootViewModel?

    init(
        breedRepository: BreedRepository,
        favoriteRepository: FavoriteRepository
    ) {
        self.breedRepository = breedRepository
        self.favoriteRepository = favoriteRepository
    }

    func makeBreedRootView(navDelegate: BreedNavDelegate?) -> BreedRootView {
        let viewModel = breedRootViewModel ?? BreedRootViewModel(
            breedRepository: breedRepository,
            favoriteRepository: favoriteRepository
        )

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
