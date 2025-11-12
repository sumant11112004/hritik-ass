import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @EnvironmentObject var favorites: FavoritesStore

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search anime...", text: $viewModel.query, onCommit: {
                        viewModel.search()
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: { viewModel.search() }) {
                        Image(systemName: "magnifyingglass")
                    }
                    .padding(.leading, 4)
                }
                .padding()

                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let err = viewModel.errorMessage {
                    Text("Error: \(err)")
                        .foregroundColor(.red)
                        .padding()
                    Spacer()
                } else if viewModel.results.isEmpty {
                    Text("No results yet. Try searching for an anime.")
                        .foregroundColor(.secondary)
                        .padding()
                    Spacer()
                } else {
                    List(viewModel.results) { anime in
                        AnimeRow(anime: anime)
                            .environmentObject(favorites)
                    }
                }
            }
            .navigationTitle("Anime Explorer")
        }
    }
}

struct AnimeRow: View {
    let anime: Anime
    @EnvironmentObject var favorites: FavoritesStore

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: anime.imageURL ?? "")) { phase in
                if let img = phase.image {
                    img.resizable().scaledToFill()
                } else if phase.error != nil {
                    Color.gray
                } else {
                    ProgressView()
                }
            }
            .frame(width: 80, height: 110)
            .clipped()
            .cornerRadius(6)

            VStack(alignment: .leading, spacing: 6) {
                Text(anime.title)
                    .font(.headline)
                Text(anime.genres.joined(separator: ", "))
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(anime.synopsis ?? "No synopsis")
                    .font(.subheadline)
                    .lineLimit(3)
            }

            Spacer()

            Button(action: { favorites.toggle(anime) }) {
                Image(systemName: favorites.isFavorite(anime) ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding(.vertical, 8)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
            .environmentObject(FavoritesStore())
    }
}
