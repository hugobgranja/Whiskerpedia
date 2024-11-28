import SwiftUI
import BreedAPI
import BreedMocks

public struct BreedListView: View {
    private let breeds: [Breed]
    private weak var navDelegate: (any BreedNavDelegate)?

    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    public init(
        breeds: [Breed],
        navDelegate: (any BreedNavDelegate)?
    ) {
        self.breeds = breeds
        self.navDelegate = navDelegate
    }

    public var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(breeds) { breed in
                    BreedItemView(
                        imageUrl: breed.imageUrl,
                        name: breed.name
                    )
                    .onTapGesture {
                        navDelegate?.goToDetail(breed: breed)
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Whiskerpedia")
    }
}

#Preview {
    BreedListView(
        breeds: BreedRepositoryMock().breeds,
        navDelegate: nil
    )
}