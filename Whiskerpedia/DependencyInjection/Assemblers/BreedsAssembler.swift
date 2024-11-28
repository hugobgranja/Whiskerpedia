import BackpackDI
import BreedAPI
import BreedImpl
import CatClientAPI
import DatabaseAPI
import DatabaseImpl
import SwiftData

@MainActor
public final class BreedAssembler {
    static func assemble(_ container: Container) {
        container.autoRegister(BreedServiceMapper.self, using: BreedMapperImpl.init)

        container.register(BreedRepository.self) { r in
            let database = DatabaseImpl(
                container: container.resolve(ModelContainer.self),
                mapper: BreedMapperImpl()
            )

            return BreedRepositoryImpl(
                client: r.resolve(CatClient.self),
                baseURL: r.resolve(AppConfig.self).catServiceBaseUrl,
                mapper: r.resolve(BreedServiceMapper.self),
                database: database
            )
        }
    }
}
