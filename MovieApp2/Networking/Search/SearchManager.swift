import Foundation

class SearchManager {
    func searchMovies(query: String, completion: @escaping ([Movie]?, String?) -> Void) {
        guard let url = NetworkConstants.createURL(for: "search", endpoint: "movie") else {
            completion(nil, "Invalid URL")
            return
        }
        
        let parameters: [String: Any] = [
            "query": query,
            "page": 1
        ]
        
        NetworkManager.shared.fetch(urlString: url.absoluteString, parameters: parameters) { (response: MovieResponse?, error) in
            if let error = error {
                completion(nil, error)
            } else {
                completion(response?.results, nil)
            }
        }
    }
}
