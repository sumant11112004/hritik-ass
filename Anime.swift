import Foundation

struct AnimeResponse: Codable {
    let data: [AnimeData]
}

struct AnimeData: Codable {
    let mal_id: Int
    let title: String
    let synopsis: String?
    let rating: String?
    let episodes: Int?
    let images: ImageContainer?
    let genres: [Genre]?

    func toAnime() -> Anime {
        return Anime(
            id: mal_id,
            title: title,
            synopsis: synopsis,
            rating: rating,
            episodes: episodes,
            imageURL: images?.jpg?.image_url,
            genres: genres?.map { $0.name } ?? []
        )
    }
}

struct ImageContainer: Codable {
    let jpg: ImageLinks?
}

struct ImageLinks: Codable {
    let image_url: String?
}

struct Genre: Codable {
    let mal_id: Int?
    let type: String?
    let name: String
}

struct Anime: Identifiable, Codable {
    let id: Int
    let title: String
    let synopsis: String?
    let rating: String?
    let episodes: Int?
    let imageURL: String?
    let genres: [String]
}
