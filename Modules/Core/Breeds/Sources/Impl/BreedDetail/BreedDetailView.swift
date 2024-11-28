import SwiftUI
import BreedsAPI
import BreedsMocks
import Kingfisher

public struct BreedDetailView: View {
    private let model: BreedDetailModel

    public init(model: BreedDetailModel) {
        self.model = model
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                KFImage(model.imageUrl)
                    .placeholder {
                        Color.gray.opacity(0.3)
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: 300)
                    .cornerRadius(8)

                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Origin:")
                            .font(.headline)
                        Text(model.breed.origin)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }

                    VStack(alignment: .leading) {
                        Text("Temperament:")
                            .font(.headline)
                        Text(model.breed.temperament)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }

                    VStack(alignment: .leading) {
                        Text("Description:")
                            .font(.headline)
                        Text(model.breed.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
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
            breed: BreedRepositoryMock().breeds[0]
        )
    )
}
