import Foundation
import BackpackDI
import DatabaseAPI
import DatabaseImpl
import SwiftData
import BreedAPI

@MainActor
public final class DatabaseAssembler {
    static func assemble(_ container: Container) {
        container.register(ModelContainer.self, lifetime: .singleton) { _ in
            let schema = Schema([BreedEntity.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }
    }
}
