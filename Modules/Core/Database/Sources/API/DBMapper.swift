import Foundation
import SwiftData

public protocol DBMapper<M, S>: Sendable {
    associatedtype M: PersistentModel
    associatedtype S: Sendable

    func map(entity: M) -> S
    func map(object: S) -> M
}
