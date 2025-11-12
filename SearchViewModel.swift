import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results: [Anime] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    private var searchTask: Task<Void, Never>? = nil

    func search() {
        // Debounce / cancel previous
        searchTask?.cancel()
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { self.results = []; return }

        isLoading = true
        errorMessage = nil

        searchTask = Task {
            do {
                let items = try await JikanAPI.shared.searchAnime(query: q)
                if Task.isCancelled { return }
                results = items
            } catch {
                if Task.isCancelled { return }
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
