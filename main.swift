import SwiftUI

@main
struct AnimeExplorerApp: App {
    @StateObject private var favorites = FavoritesStore()

    var body: some Scene {
        WindowGroup {
            SearchView(viewModel: SearchViewModel())
                .environmentObject(favorites)
        }
    }
}
