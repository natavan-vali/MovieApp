import Foundation

enum MoviesEndpoint: String, Endpoint {
    case nowPlaying = "now_playing"
    case popular = "popular"
    case topRated = "top_rated"
    case upcoming = "upcoming"
    
    var url: URL? {
        switch self {
        case .nowPlaying:
            return NetworkConstants.createURL(for: "movie", endpoint: self.rawValue)
        case .popular:
            return NetworkConstants.createURL(for: "movie", endpoint: self.rawValue)
        case .topRated:
            return NetworkConstants.createURL(for: "movie", endpoint: self.rawValue)
        case .upcoming:
            return NetworkConstants.createURL(for: "movie", endpoint: self.rawValue)
        }
    }
}
