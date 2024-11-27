import Foundation
import BreedsAPI

@MainActor
public protocol BreedListNavDelegate: AnyObject {
    func goToDetail(breed: Breed)
}
