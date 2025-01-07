import Foundation

class MoviesManager {
    static let shared = MoviesManager()
    
    private init() {}
    
    func fetchMovies(endpoint: MoviesEndpoint, completion: @escaping ([Movie]?, String?) -> Void) {
        guard let url = endpoint.url else {
            completion(nil, "Invalid URL for endpoint \(endpoint)")
            return
        }
        
        NetworkManager.shared.fetch(urlString: url.absoluteString) { (result: MovieResponse?, errorMessage) in
            if let errorMessage = errorMessage {
                completion(nil, errorMessage)
                return
            }
            completion(result?.results, nil)
        }
    }
    
    func fetchMovieDetails(id: Int, completion: @escaping (Movie?, String?) -> Void) {
        let urlString = "\(NetworkConstants.baseURL)/movie/\(id)?api_key=\(NetworkConstants.apiKey)&language=en-US"
        
        guard URL(string: urlString) != nil else {
            completion(nil, "Invalid URL")
            return
        }
        
        NetworkManager.shared.fetch(urlString: urlString) { (result: Movie?, errorMessage) in
            if let errorMessage = errorMessage {
                completion(nil, errorMessage)
                return
            }
            
            guard let movie = result else {
                completion(nil, "Movie not found.")
                return
            }
            
            completion(movie, nil)
        }
    }
}

