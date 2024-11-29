import Foundation
import BreedAPI

public final class BreedRepositoryMock: BreedRepository {
    public let breeds = [
        Breed(
            id: "1",
            name: "Abyssinian",
            origin: "Ethiopia",
            temperament: "Active, Energetic, Social, Playful, Intelligent",
            description: "Abyssinians are known for their curiosity and high energy levels, making them one of the most active cat breeds.",
            imageUrl: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg",
            isFavorite: false
        ),
        Breed(
            id: "2",
            name: "Bengal",
            origin: "United States",
            temperament: "Alert, Agile, Energetic, Demanding, Intelligent",
            description: "Bengals have a wild appearance with a playful and active personality. They enjoy climbing and are very intelligent.",
            imageUrl: "https://cdn2.thecatapi.com/images/O3btzLlsO.jpg",
            isFavorite: true
        ),
        Breed(
            id: "3",
            name: "Persian",
            origin: "Iran",
            temperament: "Affectionate, Loyal, Quiet, Sweet",
            description: "Persians are known for their calm demeanor and luxurious, long coats. They are great companions and enjoy lounging around.",
            imageUrl: "https://cdn2.thecatapi.com/images/-Zfz5z2jK.jpg",
            isFavorite: false
        ),
        Breed(
            id: "4",
            name: "Siamese",
            origin: "Thailand",
            temperament: "Affectionate, Sociable, Intelligent, Playful",
            description: "Siamese cats are known for their vocal nature and striking blue eyes. They are highly social and love interacting with their owners.",
            imageUrl: "https://cdn2.thecatapi.com/images/ai6Jps4sx.jpg",
            isFavorite: false
        ),
        Breed(
            id: "5",
            name: "Maine Coon",
            origin: "United States",
            temperament: "Gentle, Friendly, Intelligent, Playful",
            description: "Maine Coons are one of the largest cat breeds, known for their friendly nature and adaptability. They are great with families.",
            imageUrl: "https://cdn2.thecatapi.com/images/6PvbDZidB.jpg",
            isFavorite: true
        ),
        Breed(
            id: "6",
            name: "Ragdoll",
            origin: "United States",
            temperament: "Affectionate, Gentle, Relaxed, Sociable",
            description: "Ragdolls are known for their docile and gentle nature. They often go limp when held, hence the name 'Ragdoll.'",
            imageUrl: "https://cdn2.thecatapi.com/images/o5zPdxs4T.jpg",
            isFavorite: false
        ),
        Breed(
            id: "7",
            name: "Sphynx",
            origin: "Canada",
            temperament: "Affectionate, Energetic, Friendly, Playful",
            description: "The Sphynx is a hairless breed with a unique appearance and a warm, affectionate personality. They love attention and cuddling.",
            imageUrl: "https://cdn2.thecatapi.com/images/hBXicehMA.jpg",
            isFavorite: false
        ),
        Breed(
            id: "8",
            name: "Scottish Fold",
            origin: "Scotland",
            temperament: "Loving, Intelligent, Calm, Sociable",
            description: "Scottish Folds are known for their folded ears and calm, friendly personalities. They are great companions.",
            imageUrl: "https://cdn2.thecatapi.com/images/oc5.jpg",
            isFavorite: false
        ),
        Breed(
            id: "9",
            name: "British Shorthair",
            origin: "United Kingdom",
            temperament: "Affectionate, Easy Going, Loyal, Patient",
            description: "British Shorthairs are stocky cats with dense coats. They are known for their calm demeanor and loyalty.",
            imageUrl: "https://cdn2.thecatapi.com/images/cDuJvPucD.jpg",
            isFavorite: false
        )
    ]

    public init() {}

    public func getAll() -> AsyncThrowingStream<[BreedAPI.Breed], any Error> {
        return AsyncThrowingStream { [breeds] continuation in
            continuation.yield(breeds)
            continuation.finish()
        }
    }

    public func search(query: String) throws -> [Breed] {
        return breeds.filter { $0.name.contains(query) }
    }
}
