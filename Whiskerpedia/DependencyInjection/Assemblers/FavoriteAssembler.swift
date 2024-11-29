import BackpackDI
import FavoriteAPI
import FavoriteImpl

public final class FavoriteAssembler {
    static func assemble(_ container: Container) {
        container.autoRegister(FavoriteRepository.self, using: FavoriteRepositoryImpl.init)
    }
}
