import Foundation
import SwiftData

public protocol Database: Sendable {
    func makeContext() -> ModelContext
    
    func fetch<M: PersistentModel>(
        type: M.Type,
        using context: ModelContext,
        matching predicate: Predicate<M>?,
        sortedBy sortDescriptors: [SortDescriptor<M>]
    ) throws -> [M]

    func add<M: PersistentModel>(_ model: M, using context: ModelContext)
    func add<M: PersistentModel>(_ models: [M], using context: ModelContext)
    func delete<M: PersistentModel>(using context: ModelContext, matching predicate: Predicate<M>) throws
    func save(context: ModelContext) throws
}

public extension Database {
    func fetchAll<M: PersistentModel>(
        type: M.Type,
        using context: ModelContext
    ) throws -> [M] {
        return try fetch(type: type, using: context, matching: nil, sortedBy: [])
    }

    func fetchAll<M: PersistentModel>(
        type: M.Type,
        using context: ModelContext,
        sortedBy sortDescriptors: [SortDescriptor<M>]
    ) throws -> [M] {
        return try fetch(type: type, using: context, matching: nil, sortedBy: sortDescriptors)
    }

    func fetch<M: PersistentModel>(
        type: M.Type,
        using context: ModelContext,
        matching predicate: Predicate<M>
    ) throws -> [M] {
        return try fetch(type: type, using: context, matching: predicate, sortedBy: [])
    }
}
