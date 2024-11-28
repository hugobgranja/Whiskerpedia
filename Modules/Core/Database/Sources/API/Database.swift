import Foundation
import SwiftData

@MainActor
public protocol Database: Sendable {
    func fetch<M: PersistentModel>(
        type: M.Type,
        matching predicate: Predicate<M>?,
        sortedBy sortDescriptors: [SortDescriptor<M>]
    ) throws -> [M]

    func add<M: PersistentModel>(_ object: M) throws
    func delete<M: PersistentModel>(_ object: M) throws
    func save() throws
}

public extension Database {
    func fetchAll<M: PersistentModel>(type: M.Type) throws -> [M] {
        return try fetch(type: type, matching: nil, sortedBy: [])
    }

    func fetchAll<M: PersistentModel>(
        type: M.Type,
        sortedBy sortDescriptors: [SortDescriptor<M>]
    ) throws -> [M] {
        return try fetch(type: type, matching: nil, sortedBy: sortDescriptors)
    }

    func fetch<M: PersistentModel>(
        type: M.Type,
        matching predicate: Predicate<M>
    ) throws -> [M] {
        return try fetch(type: type, matching: predicate, sortedBy: [])
    }
}
