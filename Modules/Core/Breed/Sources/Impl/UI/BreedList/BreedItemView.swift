import SwiftUI
import BreedAPI
import BreedMocks
import Kingfisher

struct BreedItemView: View {
    private let breed: Breed
    private let imageUrl: URL?
    private let onToggleFavorite: (String) -> Void
    private var favoriteImageName: String { breed.isFavorite ? "star.fill" : "star" }

    init(
        breed: Breed,
        onToggleFavorite: @escaping (String) -> Void
    ) {
        self.breed = breed
        self.imageUrl = breed.imageUrl.flatMap { URL(string: $0) }
        self.onToggleFavorite = onToggleFavorite
    }

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topTrailing) {
                KFImage(imageUrl)
                    .placeholder {
                        Color.gray.opacity(0.3)
                    }
                    .resizable()
                    .aspectRatio(3 / 4, contentMode: .fill)
                    .cornerRadius(8)

                Button(action: {
                    onToggleFavorite(breed.id)
                }) {
                    Image(systemName: favoriteImageName)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.yellow)
                        .padding(8)
                        .background(Color.black.opacity(0.2))
                        .clipShape(Circle())
                }
                .padding(8)
            }

            Text(breed.name)
                .font(.caption)
                .lineLimit(1)
        }
    }
}

#Preview {
    BreedItemView(
        breed: BreedRepositoryMock().breeds[0],
        onToggleFavorite: { _ in }
    )
}
