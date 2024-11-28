import SwiftUI
import SwiftData
import BreedImpl

@main
struct WhiskerpediaApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    private let container = AppContainer()
    private let appCoordinator: AppCoordinator

    init() {
        appCoordinator = container.resolve(AppCoordinator.self)
    }

    var body: some Scene {
        WindowGroup {
            appCoordinator.getInitialView()
        }
        .modelContainer(sharedModelContainer)
    }
}
