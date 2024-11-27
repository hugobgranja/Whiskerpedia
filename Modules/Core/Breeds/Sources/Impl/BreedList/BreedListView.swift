import SwiftUI
import BreedsMocks

public struct BreedListView: View {
    private let viewModel: BreedListViewModel
    private weak var navDelegate: (any BreedListNavDelegate)?

    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    public init(
        viewModel: BreedListViewModel,
        navDelegate: (any BreedListNavDelegate)?
    ) {
        self.viewModel = viewModel
        self.navDelegate = navDelegate
    }

    public var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(viewModel.breeds) { breed in
                    BreedItemView(
                        imageUrl: breed.image?.url,
                        name: breed.name
                    )
                    .onTapGesture {
                        navDelegate?.goToDetail(breed: breed)
                    }
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
        ),
        navDelegate: nil
    )
}
