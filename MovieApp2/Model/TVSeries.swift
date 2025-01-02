import Foundation

struct TVSeries: Codable, ContentCollectionViewCellProtocol {
    let id: Int
    let title: String?
    let posterPath: String?
    let backdropPath: String?
    let overview: String?
    let releaseDate: String?
    let language: String?
    let popularity: Double?
    let rating: Double?
    let genres: [Genre]?
    let runtime: Int?
    let productionCompanies: [ProductionCompany]?
    let numberOfSeasons: Int?
    let numberOfEpisodes: Int?
    
    var titleText: String {
        return title ?? "Unknown Title"
    }
    
    var posterURL: String {
        if let posterPath = posterPath {
            return "https://image.tmdb.org/t/p/w500\(posterPath)"
        } else {
            return "https://via.placeholder.com/150"
        }
    }
    
    var backdropURL: String {
        if let backdropPath = backdropPath {
            return "https://image.tmdb.org/t/p/w500\(backdropPath)"
        } else {
            return "https://via.placeholder.com/500x280"
        }
    }
    
    var tvSeriesLanguage: String {
        return language ?? "Unknown Language"
    }
    
    var tvSeriesPopularity: String {
        return popularity.map { String($0) } ?? "N/A"
    }
    
    var tvSeriesRating: String {
        return rating.map { String($0) } ?? "N/A"
    }
    
    var tvSeriesGenre: String {
        return genres?.map { $0.name }.joined(separator: ", ") ?? "Unknown Genre"
    }
    
    var productionCompaniesNames: String {
        guard let companies = productionCompanies else { return "No production companies available" }
        return companies.map { $0.name }.joined(separator: ", ")
    }
    
    var seasonsAndEpisodes: String {
        guard let seasons = numberOfSeasons, let episodes = numberOfEpisodes else { return "No data available" }
        return "\(seasons) seasons, \(episodes) episodes"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, overview, releaseDate, popularity, genres, runtime
        case title = "name"
        case language = "original_language"
        case rating = "vote_average"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case backdropPath = "backdrop_path"
        case numberOfSeasons = "number_of_seasons"
        case numberOfEpisodes = "number_of_episodes"
    }
}

struct TVSeriesResponse: Codable {
    let results: [TVSeries]
}
