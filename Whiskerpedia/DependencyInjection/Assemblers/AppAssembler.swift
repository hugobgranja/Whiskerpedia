import BackpackDI
import BreedAPI
import BreedImpl

@MainActor
public final class AppAssembler {
    static func assemble(_ container: Container) {
        container.autoRegister(AppFactory.self, using: AppFactory.init)
        container.autoRegister(AppCoordinator.self, using: AppCoordinator.init)
    }
}
