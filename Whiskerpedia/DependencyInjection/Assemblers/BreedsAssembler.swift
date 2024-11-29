import BackpackDI
import BreedAPI
import BreedImpl
import CatClientAPI
import DatabaseAPI
import DatabaseImpl
import FavoriteAPI

public final class BreedAssembler {
    static func assemble(_ container: Container) {
        container.autoRegister(BreedMapper.self, using: BreedMapperImpl.init)

        container.register(BreedRepository.self) { r in
            return BreedRepositoryImpl(
                client: r.resolve(CatClient.self),
                baseURL: r.resolve(AppConfig.self).catServiceBaseUrl,
                mapper: r.resolve(BreedMapper.self),
                database: r.resolve(Database.self),
                favoriteRepository: r.resolve(FavoriteRepository.self)
            )
        }
    }
}
