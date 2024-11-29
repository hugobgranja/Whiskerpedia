import Foundation

public protocol BreedMapper: Sendable {
    func map(entity: BreedEntity, isFavorite: Bool) -> Breed
    func map(breed: Breed) -> BreedEntity
    func map(dto: BreedDTO, isFavorite: Bool) -> Breed
}
