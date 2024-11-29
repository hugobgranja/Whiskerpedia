import Foundation
import SwiftData

@Model
public final class FavoriteEntity {
    @Attribute(.unique) public var id: String

    public init(
        id: String
    ) {
        self.id = id
    }
}
