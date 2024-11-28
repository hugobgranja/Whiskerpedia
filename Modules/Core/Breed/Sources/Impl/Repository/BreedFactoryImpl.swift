import Foundation
import BreedAPI

public final class BreedFactoryImpl: BreedFactory {
    public init() {}
    
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

    public func map(entity: BreedEntity) -> Breed {
        return Breed(
            id: entity.id,
            name: entity.name,
            origin: entity.origin,
            temperament: entity.temperament,
            description: entity.info,
            imageUrl: entity.imageUrl,
            isFavorite: entity.isFavorite
        )
    }

    public func map(domain: Breed) -> BreedEntity {
        return BreedEntity(
            id: domain.id,
            name: domain.name,
            origin: domain.origin,
            temperament: domain.temperament,
            info: domain.description,
            imageUrl: domain.imageUrl,
            isFavorite: domain.isFavorite
        )
    }
}
