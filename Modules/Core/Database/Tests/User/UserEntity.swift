import Foundation
import SwiftData

@Model
final class UserEntity {
    @Attribute(.unique) var id: UUID
    var name: String

    init(
        id: UUID,
        name: String
    ) {
        self.id = id
        self.name = name
    }
}
