import BreedsImpl
import SwiftUI

@MainActor
final class AppCoordinator {
    enum Destination: Hashable {
        case placeholder
    }

    @Bindable var navPath = ObservableNavigationPath()
    private let breedsListViewFactory: () -> BreedListView

    init(
        breedsListViewFactory: @escaping () -> BreedListView
    ) {
        self.breedsListViewFactory = breedsListViewFactory
    }

    func getInitialView() -> some View {
        let initialView = breedsListViewFactory()

        return NavigationStack(path: $navPath.path) {
            initialView
                .navigationDestination(
                    for: Destination.self,
                    destination: destinationView(for:)
                )
        }
    }

    private func destinationView(for destination: Destination) -> some View {
        switch destination {
        case .placeholder: EmptyView()
        }
    }

    private func go(to destination: Destination) {
        navPath.append(destination)
    }
}

@MainActor
@Observable
public final class ObservableNavigationPath {
    public var path = NavigationPath()

    public init() {}

    public func append<V>(_ value: V) where V: Hashable {
        path.append(value)
    }
}
