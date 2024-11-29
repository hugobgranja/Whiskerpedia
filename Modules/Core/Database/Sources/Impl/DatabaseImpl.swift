import Foundation
import SwiftData
import DatabaseAPI

public final class DatabaseImpl: Database {
    private let container: ModelContainer

    public init(container: ModelContainer) {
        self.container = container
    }

    public func makeContext() -> ModelContext {
        return ModelContext(container)
    }

    public func fetch<M: PersistentModel>(
        type: M.Type,
        using context: ModelContext,
        matching predicate: Predicate<M>? = nil,
        sortedBy sortDescriptors: [SortDescriptor<M>] = []
    ) throws -> [M] {
        let fetchDescriptor = FetchDescriptor<M>(predicate: predicate, sortBy: sortDescriptors)
        return try context.fetch(fetchDescriptor)
    }

    public func add<M: PersistentModel>(
        _ model: M,
        using context: ModelContext
    ) {
        context.insert(model)
    }

    public func add<M: PersistentModel>(
        _ models: [M],
        using context: ModelContext
    ) {
        models.forEach { add($0, using: context) }
    }

    public func delete<M: PersistentModel>(
        using context: ModelContext,
        matching predicate: Predicate<M>
    ) throws {
        let fetchDescriptor = FetchDescriptor<M>(predicate: predicate)
        let models = try context.fetch(fetchDescriptor)

        for model in models {
            context.delete(model)
        }
    }

    public func save(context: ModelContext) throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
