import Foundation

enum PeopleEndpoint: String, Endpoint {
    case popular = "popular"
    case personDetails = "details" 
    
    var url: URL? {
        switch self {
        case .popular:
            return NetworkConstants.createURL(for: "person", endpoint: self.rawValue)
        case .personDetails:
            return nil
        }
    }
    
    func detailsURL(for id: Int) -> URL? {
        return NetworkConstants.createURL(for: "person", endpoint: "\(id)")
    }
}
