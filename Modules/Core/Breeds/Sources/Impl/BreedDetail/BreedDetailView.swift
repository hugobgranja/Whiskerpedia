import SwiftUI
import BreedsAPI
import Kingfisher

public struct BreedDetailView: View {
    private let viewModel: BreedDetailViewModel

    public init(viewModel: BreedDetailViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                KFImage(viewModel.imageUrl)
                    .placeholder {
                        Color.gray.opacity(0.3)
                            .frame(height: 300)
                    }
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(8)

                // Breed Name
                Text(viewModel.breed.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)

                // Origin
                HStack {
                    Text("Origin:")
                        .font(.headline)
                    Text(viewModel.breed.origin)
                        .font(.body)
                        .foregroundColor(.secondary)
                }

                // Temperament
                VStack(alignment: .leading) {
                    Text("Temperament:")
                        .font(.headline)
                    Text(viewModel.breed.temperament)
                        .font(.body)
                        .foregroundColor(.secondary)
                }

                // Description
                VStack(alignment: .leading) {
                    Text("Description:")
                        .font(.headline)
                    Text(viewModel.breed.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.breed.name)
    }
}

#Preview {
    BreedDetailView(
        viewModel: BreedDetailViewModel(
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
