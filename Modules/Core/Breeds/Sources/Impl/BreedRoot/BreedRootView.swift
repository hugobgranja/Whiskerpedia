import SwiftUI
import BreedsAPI
import BreedsMocks

public struct BreedRootView: View {
    @Bindable private var viewModel: BreedRootViewModel
    private weak var navDelegate: (any BreedNavDelegate)?

    public init(
        viewModel: BreedRootViewModel,
        navDelegate: (any BreedNavDelegate)?
    ) {
        self.viewModel = viewModel
        self.navDelegate = navDelegate
    }

    public var body: some View {
        BreedListView(
            breeds: viewModel.breeds,
            navDelegate: navDelegate
        )
        .task(viewModel.getBreeds)
        .searchable(text: $viewModel.query)
        .onChange(of: viewModel.query) {
            Task { await viewModel.search() }
        }
    }
}

#Preview {
    NavigationStack {
        BreedRootView(
            viewModel: BreedRootViewModel(breedRepository: BreedRepositoryMock()),
            navDelegate: nil
        )
    }
}
