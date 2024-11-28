import BackpackDI
import CatClientAPI
import BreedAPI
import BreedImpl

@MainActor
public final class BreedsAssembler {
    static func assemble(_ container: Container) {
        container.autoRegister(
            BreedFactory.self,
            using: BreedFactoryImpl.init
        )

        container.register(BreedRepository.self) { r in
            BreedRepositoryImpl(
                client: r.resolve(CatClient.self),
                baseURL: r.resolve(AppConfig.self).catServiceBaseUrl,
                factory: r.resolve(BreedFactory.self)
            )
        }
    }
}
