import BackpackDI
import CatClientAPI
import BreedsAPI
import BreedsImpl

@MainActor
public final class BreedsAssembler {
    static func assemble(_ container: Container) {
        container.register(BreedRepository.self) { r in
            BreedRepositoryImpl(
                client: r.resolve(CatClient.self),
                baseURL: r.resolve(AppConfig.self).catServiceBaseUrl
            )
        }

        container.autoRegister(BreedListViewModel.self, using: BreedListViewModel.init)

        container.autoRegister(BreedListView.self, using: BreedListView.init)
    }
}
