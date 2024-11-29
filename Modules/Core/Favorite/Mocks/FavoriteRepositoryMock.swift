import Foundation
import FavoriteAPI

public final class FavoriteRepositoryMock: FavoriteRepository {
    public init() {}
    
    public func add(id: String) throws {}

    public func isFavorite(id: String) throws -> Bool {
        return Bool.random()
    }

    public func delete(id: String) throws {}
}
