import Foundation
import BreedAPI
import CatClientAPI
import DatabaseAPI
import FavoriteAPI
import SwiftData

public final class BreedRepositoryImpl: BreedRepository {
    enum Constants {
        static let breedsPath = "v1/breeds"
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

    public func getAll() -> AsyncThrowingStream<[Breed], Error> {
        return AsyncThrowingStream { continuation in
            Task { [weak self] in
                guard let self else { return }
                let context = database.makeContext()

                let initial = try getAll(context: context)
                continuation.yield(initial)

                try await requestBreeds()
                let final = try getAll(context: context)
                continuation.yield(final)
                continuation.finish()
            }
        }
    }

    private func getAll(context: ModelContext) throws -> [Breed] {
        let sortDescriptor = SortDescriptor(\BreedEntity.name)

        return try database.fetchAll(
            type: BreedEntity.self,
            using: context,
            sortedBy: [sortDescriptor]
        )
        .map { map(from: $0) }
    }

    private func requestBreeds() async throws {
        guard
            let url = URL(string: "\(baseURL)\(Constants.breedsPath)")
        else {
            throw URLError(.badURL)
        }

        let response = try await client.request(url: url, method: .get)
        let breeds = try response.decode([BreedDTO].self).map { map(from: $0) }
        try store(breeds: breeds)
    }

    public func search(query: String) throws -> [Breed] {
        let context = database.makeContext()
        let predicate = #Predicate<BreedEntity> { $0.name.contains(query) }
        return try database.fetch(type: BreedEntity.self, using: context, matching: predicate)
            .map { map(from: $0) }
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
