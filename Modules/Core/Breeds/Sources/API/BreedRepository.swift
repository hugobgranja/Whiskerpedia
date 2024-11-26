import Foundation

public protocol BreedRepository: Sendable {
    func getBreeds(limit: Int, page: Int) async throws -> BreedsPage
}
