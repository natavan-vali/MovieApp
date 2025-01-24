import Foundation

enum SearchEndpoint: String, Endpoint {
    case movie = "movie"
    case tvSeries = "tv"
    
    var url: URL? {
        return NetworkConstants.createURL(for: "search", endpoint: self.rawValue)
    }
}
