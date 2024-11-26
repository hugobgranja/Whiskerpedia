import BackpackDI
import BreedsImpl

@MainActor
public final class AppAssembler {
    static func assemble(_ container: Container) {
        container.register(AppCoordinator.self) { r in
            AppCoordinator(breedsListViewFactory: {
                r.resolve(BreedListView.self)
            })
        }
    }
}
