import Foundation
import DatabaseAPI
import FavoriteAPI

public final class FavoriteRepositoryImpl: FavoriteRepository {
    private let database: Database

    public init(database: Database) {
        self.database = database
    }

    public func add(id: String) throws {
        let context = database.makeContext()
        let model = FavoriteEntity(id: id)
        database.add(model, using: context)
        try database.save(context: context)
    }

    public func isFavorite(id: String) throws -> Bool {
        let context = database.makeContext()
        let predicate = #Predicate<FavoriteEntity> { $0.id == id }
        let fetchedFavorites = try database.fetch(
            type: FavoriteEntity.self,
            using: context,
            matching: predicate
        )

        return !fetchedFavorites.isEmpty
    }

    public func delete(id: String) throws {
        let context = database.makeContext()
        let predicate = #Predicate<FavoriteEntity> { $0.id == id }
        try database.delete(using: context, matching: predicate)
        try database.save(context: context)
    }
}
