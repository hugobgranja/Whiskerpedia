import Foundation

public protocol BreedRepository: Sendable {
    func getAll() -> AsyncThrowingStream<[Breed], Error>
    func search(query: String) throws -> [Breed]
}
