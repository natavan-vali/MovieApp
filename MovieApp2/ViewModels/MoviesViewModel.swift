import Foundation

struct MovieListModel {
    let title: String
    let movies: [Movie]
}

class MoviesViewModel {
    var items = [MovieListModel]()
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func fetchMovies() {
        let endpoints: [MoviesEndpoint] = [.nowPlaying, .popular, .topRated, .upcoming]
        
        for endpoint in endpoints {
            getMovieItems(endpoint: endpoint)
        }
    }
    
    private func getMovieItems(endpoint: MoviesEndpoint) {
        MoviesManager.fetchMovies(endpoint: endpoint) { [weak self] movies, errorMessage in
            if let errorMessage = errorMessage {
                self?.error?(errorMessage)
            } else if let movies = movies {
                let listTitle = self?.getTitle(for: endpoint) ?? "Unknown"
                self?.items.append(.init(title: listTitle, movies: movies))
                self?.success?()
            }
        }
    }
    
    private func getTitle(for endpoint: MoviesEndpoint) -> String {
        switch endpoint {
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}
