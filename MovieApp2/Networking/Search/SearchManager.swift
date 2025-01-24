import Foundation

class SearchManager: SearchUseCase {
    static let shared = SearchManager()
    
    private init() {}
    
    func searchItems<T: Decodable>(query: String, type: SearchType, completion: @escaping (T?, String?) -> Void) {
        let endpoint: String
        let parameters: [String: Any]
        
        switch type {
        case .movie:
            endpoint = "movie"
            parameters = [
                "query": query,
                "page": 1
            ]
        case .tvSeries:
            endpoint = "tv"
            parameters = [
                "query": query,
                "include_adult": false,
                "language": "en-US",
                "page": 1
            ]
        }
        
        guard let url = NetworkConstants.createURL(for: "search", endpoint: endpoint) else {
            completion(nil, "Invalid URL")
            return
        }
        
        NetworkManager.shared.fetch(urlString: url.absoluteString, parameters: parameters) { (response: T?, error) in
            if let error = error {
                completion(nil, error)
            } else {
                completion(response, nil)
            }
        }
    }
}
