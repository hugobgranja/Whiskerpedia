import Foundation
import BreedAPI

@MainActor
public protocol BreedNavDelegate: AnyObject {
    func goToDetail(breed: Breed)
}
