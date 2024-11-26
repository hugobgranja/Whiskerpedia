import BreedsAPI
import SwiftUI
import Kingfisher

struct BreedItemView: View {
    let imageUrl: URL?
    let name: String

    init(imageUrl: String?, name: String) {
        self.imageUrl = imageUrl.flatMap { URL(string: $0) }
        self.name = name
    }

    var body: some View {
        VStack(spacing: 8) {
            KFImage(imageUrl)
                .placeholder {
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundStyle(.gray)
                }
                .resizable()
                .cornerRadius(8)

            Text(name)
                .font(.headline)
                .lineLimit(1)
        }
        .frame(height: 200)
    }
}

#Preview {
    BreedItemView(
        imageUrl: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg",
        name: "Abyssinian"
    )
}
