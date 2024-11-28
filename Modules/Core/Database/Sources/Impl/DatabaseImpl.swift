import Foundation
import SwiftData
import DatabaseAPI

public final class DatabaseImpl<M: PersistentModel, S: Sendable>: Database {
    private let container: ModelContainer
    private let context: ModelContext
    private let mapper: any DBMapper<M, S>

    public init(
        container: ModelContainer,
        mapper: any DBMapper<M, S>
    ) {
        self.container = container
        self.context = ModelContext(container)
        self.mapper = mapper
    }

    public func fetch(
        matching predicate: Predicate<M>? = nil,
        sortedBy sortDescriptors: [SortDescriptor<M>] = []
    ) throws -> [S] {
        let fetchDescriptor = FetchDescriptor<M>(predicate: predicate, sortBy: sortDescriptors)
        return try context.fetch(fetchDescriptor).map { mapper.map(entity: $0) }
    }

    public func add(_ object: S) {
        let model = mapper.map(object: object)
        context.insert(model)
    }

    public func delete(matching predicate: Predicate<M>) throws {
        let fetchDescriptor = FetchDescriptor<M>(predicate: predicate)
        let models = try context.fetch(fetchDescriptor)

        for model in models {
            context.delete(model)
        }
    }

    public func save() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
