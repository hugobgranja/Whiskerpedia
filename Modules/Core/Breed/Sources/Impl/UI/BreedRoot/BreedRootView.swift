import SwiftUI
import BreedAPI
import BreedMocks
import FavoriteMocks

public struct BreedRootView: View {
    private var viewModel: BreedRootViewModel
    private weak var navDelegate: (any BreedNavDelegate)?
    @State private var searchQuery: String = ""
    @State private var searchTask: Task<Void, Never>?

    public init(
        viewModel: BreedRootViewModel,
        navDelegate: (any BreedNavDelegate)?
    ) {
        self.viewModel = viewModel
        self.navDelegate = navDelegate
    }

    public var body: some View {
        ZStack {
            BreedListView(
                breeds: viewModel.breeds,
                navDelegate: navDelegate,
                onToggleFavorite: { id in
                    Task {
                        viewModel.toggleFavorite(id: id)
                        await viewModel.getBreeds()
                    }
                }
            )

            if viewModel.isLoading {
                ProgressView()
            }
        }
        .task(viewModel.getBreeds)
        .searchable(text: $searchQuery)
        .onChange(of: searchQuery) { _, newValue in
            searchTask?.cancel()
            searchTask = Task { await viewModel.search(query: newValue) }
        }
    }
}

#Preview {
    NavigationStack {
        BreedRootView(
            viewModel: BreedRootViewModel(
                breedRepository: BreedRepositoryMock(),
                favoriteRepository: FavoriteRepositoryMock()
            ),
            navDelegate: nil
        )
    }
}
