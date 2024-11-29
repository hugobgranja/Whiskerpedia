import SwiftUI
import BreedAPI
import BreedMocks
import FavoriteMocks

public struct BreedRootView: View {
    private var viewModel: BreedRootViewModel
    private weak var navDelegate: (any BreedNavDelegate)?
    @State private var searchQuery: String = ""
    @State private var task: Task<Void, Never>?

    public init(
        viewModel: BreedRootViewModel,
        navDelegate: (any BreedNavDelegate)?
    ) {
        self.viewModel = viewModel
        self.navDelegate = navDelegate
    }

    public var body: some View {
        Group {
            switch viewModel.presentationMode {
            case .list:
                ScrollView {
                    LazyVStack(spacing: 20) {
                        BreedListView(
                            breeds: viewModel.paginatedBreeds,
                            navDelegate: navDelegate,
                            onToggleFavorite: { id in
                                Task {
                                    await viewModel.toggleFavorite(id: id)
                                    await viewModel.refreshPaginatedBreeds()
                                }
                            }
                        )
                        .animation(.default, value: viewModel.paginatedBreeds)

                        if viewModel.isNextPageAvailable {
                            ProgressView()
                                .task(viewModel.getPage)
                        }
                    }
                }

            case .search:
                ZStack {
                    BreedListView(
                        breeds: viewModel.searchBreeds,
                        navDelegate: navDelegate,
                        onToggleFavorite: { id in
                            Task {
                                await viewModel.toggleFavorite(id: id)
                                await viewModel.refreshSearchBreeds()
                            }
                        }
                    )
                    .animation(.default, value: viewModel.searchBreeds)

                    if viewModel.isLoading {
                        ProgressView()
                    }
                }
            }
        }
        .searchable(text: $searchQuery)
        .onChange(of: searchQuery) { _, newValue in
            task?.cancel()
            task = Task { await viewModel.search(query: newValue) }
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
