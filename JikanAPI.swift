import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
}

final class JikanAPI {
    static let shared = JikanAPI()
    private let baseURL = "https://api.jikan.moe/v4"

    private init() {}

    func searchAnime(query: String) async throws -> [Anime] {
        guard var components = URLComponents(string: "\(baseURL)/anime") else {
            throw APIError.invalidURL
        }
        components.queryItems = [URLQueryItem(name: "q", value: query), URLQueryItem(name: "limit", value: "25")]

        guard let url = components.url else { throw APIError.invalidURL }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
                throw APIError.requestFailed(NSError(domain: "HTTPError", code: 1))
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            let resp = try decoder.decode(AnimeResponse.self, from: data)
            return resp.data.map { $0.toAnime() }
        } catch let err as DecodingError {
            throw APIError.decodingFailed(err)
        } catch {
            throw APIError.requestFailed(error)
        }
    }
}
