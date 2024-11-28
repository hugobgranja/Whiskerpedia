import Foundation
import BreedsAPI
import CatClientAPI

public final class BreedRepositoryImpl: BreedRepository {
    enum Constants {
        static let breedsPath = "v1/breeds"
        static let searchPath = "v1/breeds/search"
        static let totalItemCountHeaderKey = "pagination-count"
    }

    private let client: CatClient
    private let baseURL: String
    private let factory: BreedFactory

    public init(
        client: CatClient,
        baseURL: String,
        factory: BreedFactory
    ) {
        self.client = client
        self.baseURL = baseURL
        self.factory = factory
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

        let breeds = try response.decode([BreedDTO].self).map { factory.map(dto: $0) }
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

        return try response.decode([BreedDTO].self).map { factory.map(dto: $0) }
    }
}
