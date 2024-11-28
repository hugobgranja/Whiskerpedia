import Foundation
import SwiftData

@MainActor
public protocol Database<M, S>: Sendable {
    associatedtype M: PersistentModel
    associatedtype S: Sendable

    func fetch(
        matching predicate: Predicate<M>?,
        sortedBy sortDescriptors: [SortDescriptor<M>]
    ) throws -> [S]

    func add(_ object: S)
    func delete(matching predicate: Predicate<M>) throws
    func save() throws
}

public extension Database {
    func fetchAll() throws -> [S] {
        return try fetch(matching: nil, sortedBy: [])
    }

    func fetchAll(
        sortedBy sortDescriptors: [SortDescriptor<M>]
    ) throws -> [S] {
        return try fetch(matching: nil, sortedBy: sortDescriptors)
    }

    func fetch(
        matching predicate: Predicate<M>
    ) throws -> [S] {
        return try fetch(matching: predicate, sortedBy: [])
    }
}
