import Foundation

enum TVSeriesEndPoint: String {
    case airingToday = "airing_today"
    case onTheAir = "on_the_air"
    case popular = "popular"
    case topRated = "top_rated"
    
    var url: URL? {
        switch self {
        case .airingToday:
            return NetworkConstants.createURL(for: "tv", endpoint: self.rawValue)
        case .onTheAir:
            return NetworkConstants.createURL(for: "tv", endpoint: self.rawValue)
        case .popular:
            return NetworkConstants.createURL(for: "tv", endpoint: self.rawValue)
        case .topRated:
            return NetworkConstants.createURL(for: "tv", endpoint: self.rawValue)
        }
    }
}
