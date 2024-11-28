import Foundation

public protocol BreedRepository: Sendable {
    func get(limit: Int, page: Int) async throws -> BreedsPage
    func search(query: String) async throws -> [Breed]
}
