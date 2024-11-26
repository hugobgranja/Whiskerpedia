import Foundation

public protocol BreedRepository {
    func getBreeds(limit: Int, page: Int) async throws -> BreedsPage
}
