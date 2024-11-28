import BreedAPI
import BreedImpl
import SwiftUI

@MainActor
final class AppCoordinator {
    enum Destination: Hashable {
        case breedDetail(breed: Breed)
    }

    @Bindable var navPath = ObservableNavigationPath()
    private let factory: AppFactory

    init(factory: AppFactory) {
        self.factory = factory
    }

    @ViewBuilder
    func getInitialView() -> some View {
        NavigationStack(path: $navPath.path) {
            factory.makeBreedRootView(navDelegate: self)
                .navigationDestination(
                    for: Destination.self,
                    destination: destinationView(for:)
                )
        }
    }

    private func destinationView(for destination: Destination) -> some View {
        switch destination {
        case .breedDetail(let breed):
            factory.makeBreedDetailView(breed: breed)
        }
    }

    private func go(to destination: Destination) {
        navPath.append(destination)
    }
}

extension AppCoordinator: BreedNavDelegate {
    func goToDetail(breed: Breed) {
        go(to: .breedDetail(breed: breed))
    }
}
