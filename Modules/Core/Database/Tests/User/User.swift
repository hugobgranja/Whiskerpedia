import Foundation
import SwiftData

struct User: Equatable, Sendable {
    let id: UUID
    let name: String

    init(
        id: UUID,
        name: String
    ) {
        self.id = id
        self.name = name
    }

    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
