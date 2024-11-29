import SwiftUI
import BreedAPI
import BreedMocks
import FavoriteMocks

public struct BreedRootView: View {
    private var viewModel: BreedRootViewModel
    private weak var navDelegate: (any BreedNavDelegate)?
    @State private var searchQuery: String = ""
    @State private var searchTask: Task<Void, Never>?
    @State private var refreshTask: Task<Void, Never>?

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
                    viewModel.toggleFavorite(id: id)
                    refreshTask = Task {
                        await refreshBreeds()
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
            refreshTask?.cancel()
            searchTask?.cancel()
            searchTask = Task { await viewModel.search(query: newValue) }
        }
        .navigationTitle("Whiskerpedia")
    }

    private func refreshBreeds() async {
        if searchQuery.isEmpty {
            await viewModel.getBreeds()
        }
        else {
            await viewModel.search(query: searchQuery)
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
