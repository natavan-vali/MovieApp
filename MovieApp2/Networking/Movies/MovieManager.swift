import Foundation

class MoviesManager: GenericMediaManager<Movie> {
    static let shared = MoviesManager()
    
    private override init() {}
    
    func fetchMovies(endpoint: MoviesEndpoint, completion: @escaping ([Movie]?, String?) -> Void) {
        fetchMedia(endpoint: endpoint, completion: completion)
    }
    
    func fetchMovieDetails(id: Int, completion: @escaping (Movie?, String?) -> Void) {
        fetchMediaDetails(id: id, completion: completion)
    }
}
