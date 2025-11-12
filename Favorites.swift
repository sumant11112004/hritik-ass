import Foundation
import Combine

final class FavoritesStore: ObservableObject {
    @Published private(set) var favorites: [Anime] = []
    private let key = "favorites.anime"

    init() {
        load()
    }

    func isFavorite(_ anime: Anime) -> Bool {
        favorites.contains(where: { $0.id == anime.id })
    }

    func toggle(_ anime: Anime) {
        if let idx = favorites.firstIndex(where: { $0.id == anime.id }) {
            favorites.remove(at: idx)
        } else {
            favorites.append(anime)
        }
        save()
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Favorites save failed: \(error)")
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key) else { return }
        do {
            favorites = try JSONDecoder().decode([Anime].self, from: data)
        } catch {
            print("Favorites load failed: \(error)")
        }
    }
}

