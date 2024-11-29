import SwiftUI
import BreedAPI
import BreedMocks
import Kingfisher

struct BreedItemView: View {
    let breed: Breed
    let imageUrl: URL?
    let onToggleFavorite: (String) -> Void
    var favoriteImageName: String { breed.isFavorite ? "star.fill" : "star" }

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
                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
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
