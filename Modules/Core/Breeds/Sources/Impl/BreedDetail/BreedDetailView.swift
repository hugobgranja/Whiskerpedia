import SwiftUI
import BreedsAPI
import Kingfisher

public struct BreedDetailView: View {
    private let model: BreedDetailModel

    public init(model: BreedDetailModel) {
        self.model = model
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                KFImage(model.imageUrl)
                    .placeholder {
                        Color.gray.opacity(0.3)
                            .frame(height: 300)
                    }
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(8)

                // Breed Name
                Text(model.breed.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)

                // Origin
                HStack {
                    Text("Origin:")
                        .font(.headline)
                    Text(model.breed.origin)
                        .font(.body)
                        .foregroundColor(.secondary)
                }

                // Temperament
                VStack(alignment: .leading) {
                    Text("Temperament:")
                        .font(.headline)
                    Text(model.breed.temperament)
                        .font(.body)
                        .foregroundColor(.secondary)
                }

                // Description
                VStack(alignment: .leading) {
                    Text("Description:")
                        .font(.headline)
                    Text(model.breed.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle(model.breed.name)
    }
}

#Preview {
    BreedDetailView(
        model: BreedDetailModel(
            breed: Breed(
                id: "1",
                name: "Abyssinian",
                origin: "Ethiopia",
                temperament: "Active, Energetic, Social, Playful, Intelligent",
                description: "Abyssinians are known for their curiosity and high energy levels, making them one of the most active cat breeds.",
                image: BreedImage(url: "https://cdn2.thecatapi.com/images/ozEvzdVM-.jpg")
            )
        )
    )
}
