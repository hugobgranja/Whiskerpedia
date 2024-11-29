import Foundation
import BreedAPI
import CatClientAPI
import DatabaseAPI
import FavoriteAPI

public final class BreedRepositoryImpl: BreedRepository {
    enum Constants {
        static let breedsPath = "v1/breeds"
        static let searchPath = "v1/breeds/search"
        static let totalItemCountHeaderKey = "pagination-count"
    }

    private let client: CatClient
    private let baseURL: String
    private let mapper: BreedMapper
    private let database: Database
    private let favoriteRepository: FavoriteRepository

    public init(
        client: CatClient,
        baseURL: String,
        mapper: BreedMapper,
        database: Database,
        favoriteRepository: FavoriteRepository
    ) {
        self.client = client
        self.baseURL = baseURL
        self.mapper = mapper
        self.database = database
        self.favoriteRepository = favoriteRepository
    }

    public func getAll() async throws -> [Breed] {
        let context = database.makeContext()
        return try database.fetchAll(type: BreedEntity.self, using: context)
            .map { map(from: $0) }
    }

    public func get(id: String) async throws -> Breed? {
        let context = database.makeContext()
        let predicate = #Predicate<BreedEntity> { $0.id == id }

        guard
            let entity = try database.fetch(
                type: BreedEntity.self,
                using: context,
                matching: predicate
            ).first
        else {
            return nil
        }

        return map(from: entity)
    }

    public func get(ids: [String]) async throws -> [Breed] {
        let context = database.makeContext()
        let predicate = #Predicate<BreedEntity> { ids.contains($0.id) }
        return try database.fetch(type: BreedEntity.self, using: context, matching: predicate)
            .map { map(from: $0) }
    }

    public func get(limit: Int, page: Int) async throws -> BreedsPage {
        let queryItems = [
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "page", value: String(page))
        ]

        guard
            let url = URL(string: "\(baseURL)\(Constants.breedsPath)")?
                .appending(queryItems: queryItems)
        else {
            throw URLError(.badURL)
        }

        let response = try await client.request(url: url, method: .get)

        let breeds = try response.decode([BreedDTO].self).map { map(from: $0) }
        try store(breeds: breeds)

        let paginationCount = response.headers?[Constants.totalItemCountHeaderKey] as? String
        let totalItemCount = paginationCount.flatMap { Int($0) } ?? 0

        return BreedsPage(
            breeds: breeds,
            totalItemCount: totalItemCount
        )
    }

    public func search(query: String) async throws -> [Breed] {
        let queryItems = [URLQueryItem(name: "q", value: query)]

        guard
            let url = URL(string: "\(baseURL)\(Constants.searchPath)")?
                .appending(queryItems: queryItems)
        else {
            throw URLError(.badURL)
        }

        let response = try await client.request(url: url, method: .get)
        let breeds = try response.decode([BreedDTO].self).map { map(from: $0) }
        try store(breeds: breeds)
        return breeds
    }

    private func map(from entity: BreedEntity) -> Breed {
        let isFavorite = (try? favoriteRepository.isFavorite(id: entity.id)) ?? false
        return mapper.map(entity: entity, isFavorite: isFavorite)
    }

    private func map(from dto: BreedDTO) -> Breed {
        let isFavorite = (try? favoriteRepository.isFavorite(id: dto.id)) ?? false
        return mapper.map(dto: dto, isFavorite: isFavorite)
    }

    private func store(breeds: [Breed]) throws {
        let context = database.makeContext()
        let entities = breeds.map { mapper.map(breed: $0) }
        database.add(entities, using: context)
        try database.save(context: context)
    }
}
