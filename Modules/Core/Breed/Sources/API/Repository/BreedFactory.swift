import Foundation

public protocol BreedFactory: Sendable {
    func map(dto: BreedDTO) -> Breed
    func map(entity: BreedEntity) -> Breed
    func map(domain: Breed) -> BreedEntity
}
