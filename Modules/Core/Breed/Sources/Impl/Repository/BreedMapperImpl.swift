import Foundation
import BreedAPI
import DatabaseAPI

public final class BreedMapperImpl: BreedMapper {
    public init() {}

    public func map(
        entity: BreedEntity,
        isFavorite: Bool
    ) -> Breed {
        Breed(
            id: entity.id,
            name: entity.name,
            origin: entity.origin,
            temperament: entity.temperament,
            description: entity.info,
            imageUrl: entity.imageUrl,
            isFavorite: isFavorite
        )
    }

    public func map(breed: Breed) -> BreedEntity {
        return BreedEntity(
            id: breed.id,
            name: breed.name,
            origin: breed.origin,
            temperament: breed.temperament,
            info: breed.description,
            imageUrl: breed.imageUrl
        )
    }

    public func map(
        dto: BreedDTO,
        isFavorite: Bool
    ) -> Breed {
        return Breed(
            id: dto.id,
            name: dto.name,
            origin: dto.origin,
            temperament: dto.temperament,
            description: dto.description,
            imageUrl: dto.image?.url,
            isFavorite: isFavorite
        )
    }
}
