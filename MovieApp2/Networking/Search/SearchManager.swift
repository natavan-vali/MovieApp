import Foundation

class SearchManager: SearchUseCase {
    static let shared = SearchManager()
    
    private init() {}
    
    func searchItems<T: Decodable>(query: String, type: SearchEndpoint, completion: @escaping (T?, String?) -> Void) {
        guard let url = type.url else {
            completion(nil, "Invalid URL")
            return
        }
        
        var parameters: [String: Any] = [
            "query": query,
            "page": 1
        ]
        
        if type == .tvSeries {
            parameters["include_adult"] = false
            parameters["language"] = NetworkConstants.language
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
