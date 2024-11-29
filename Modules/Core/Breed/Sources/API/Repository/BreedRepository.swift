import Foundation

public protocol BreedRepository: Sendable {
    func get(id: String) async throws -> Breed?
    func getAll() async throws -> [Breed]
    func get(ids: [String]) async throws -> [Breed]
    func get(limit: Int, page: Int) async throws -> BreedsPage
    func search(query: String) async throws -> [Breed]
}
