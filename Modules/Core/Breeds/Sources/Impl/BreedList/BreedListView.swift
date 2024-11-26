import SwiftUI
import BreedsMocks

struct BreedListView: View {
    private let viewModel: BreedListViewModel
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    init(viewModel: BreedListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(viewModel.breeds) { breed in
                    BreedItemView(
                        imageUrl: breed.image?.url,
                        name: breed.name
                    )
                    .aspectRatio(3 / 4, contentMode: .fit)
                }
            }
            .padding(.horizontal)
        }
        .task(viewModel.getBreeds)
    }
}

#Preview {
    BreedListView(
        viewModel: BreedListViewModel(
            breedRepository: BreedRepositoryMock()
        )
    )
}
