import SwiftUI
import SwiftData
import BreedImpl

@main
struct WhiskerpediaApp: App {
    private let container = AppContainer()
    private let appCoordinator: AppCoordinator

    init() {
        appCoordinator = container.resolve(AppCoordinator.self)
    }

    var body: some Scene {
        WindowGroup {
            appCoordinator.getInitialView()
        }
    }
}
