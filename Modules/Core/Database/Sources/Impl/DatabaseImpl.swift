import Foundation
import SwiftData
import DatabaseAPI

public final class DatabaseImpl: Database {
    private let container: ModelContainer

    public init(container: ModelContainer) {
        self.container = container
    }

    public func fetch<M: PersistentModel>(
        type: M.Type,
        matching predicate: Predicate<M>? = nil,
        sortedBy sortDescriptors: [SortDescriptor<M>] = []
    ) throws -> [M] {
        let context = container.mainContext
        let fetchDescriptor = FetchDescriptor<M>(predicate: predicate, sortBy: sortDescriptors)
        return try context.fetch(fetchDescriptor)
    }

    public func add<M: PersistentModel>(_ object: M) throws {
        let context = container.mainContext
        context.insert(object)
    }

    public func delete<M: PersistentModel>(_ object: M) throws {
        let context = container.mainContext
        context.delete(object)
    }

    public func save() throws {
        let context = container.mainContext
        if context.hasChanges {
            try context.save()
        }
    }
}
