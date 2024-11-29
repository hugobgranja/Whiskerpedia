import Foundation

public protocol FavoriteRepository: Sendable {
    func add(id: String) throws
    func isFavorite(id: String) throws -> Bool
    func delete(id: String) throws
}
