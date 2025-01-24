import Foundation

struct Movie: Codable, ContentCollectionViewCellProtocol {
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
    
    var titleText: String {
        return title ?? "Unknown Title"
    }
    
    var posterURL: String {
        if let posterPath = posterPath {
            return "\(NetworkConstants.imageBaseURL)\(posterPath)"
        } else {
            return "https://via.placeholder.com/150"
        }
    }
    
    var backdropURL: String {
        if let backdropPath = backdropPath {
            return "\(NetworkConstants.imageBaseURL)\(backdropPath)"
        } else {
            return "https://via.placeholder.com/500x280"
        }
    }
    
    var movieLanguage: String {
        return language ?? "Unknown Language"
    }
    
    var moviePopularity: String {
        return popularity.map { String($0) } ?? "N/A"
    }
    
    var movieRating: String {
        return rating.map { String($0) } ?? "N/A"
    }
    
    var movieGenre: String {
        return genres?.map { $0.name }.joined(separator: ", ") ?? "Unknown Genre"
    }
    
    var movieDuration: String {
        return runtime != nil ? "\(runtime!) min" : "N/A"
    }
    
    var productionCompaniesNames: String {
        guard let companies = productionCompanies else { return "No production companies available" }
        return companies.map { $0.name }.joined(separator: ", ")
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, releaseDate, popularity, genres, runtime
        case language = "original_language"
        case rating = "vote_average"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case backdropPath = "backdrop_path"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct ProductionCompany: Codable {
    let id: Int?
    let name: String
    let logoPath: String?
    let originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}

