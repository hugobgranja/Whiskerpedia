import Foundation
import BreedAPI
import DatabaseAPI

public final class BreedMapperImpl: DBMapper, BreedServiceMapper {
    public init() {}

    public func map(entity: BreedEntity) -> Breed {
        Breed(
            id: entity.id,
            name: entity.name,
            origin: entity.origin,
            temperament: entity.temperament,
            description: entity.info,
            imageUrl: entity.imageUrl,
            isFavorite: entity.isFavorite
        )
    }

    public func map(object: Breed) -> BreedEntity {
        return BreedEntity(
            id: object.id,
            name: object.name,
            origin: object.origin,
            temperament: object.temperament,
            info: object.description,
            imageUrl: object.imageUrl,
            isFavorite: object.isFavorite
        )
    }

    public func map(dto: BreedDTO) -> Breed {
        return Breed(
            id: dto.id,
            name: dto.name,
            origin: dto.origin,
            temperament: dto.temperament,
            description: dto.description,
            imageUrl: dto.image?.url,
            isFavorite: false
        )
    }
}
