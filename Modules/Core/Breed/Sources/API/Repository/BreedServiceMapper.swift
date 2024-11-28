import Foundation

public protocol BreedServiceMapper: Sendable {
    func map(dto: BreedDTO) -> Breed
}
