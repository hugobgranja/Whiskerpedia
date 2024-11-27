import Foundation
import BreedsAPI

@MainActor
public protocol BreedNavDelegate: AnyObject {
    func goToDetail(breed: Breed)
}
