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
        MoviesManager.shared.fetchMovies(endpoint: endpoint) { [weak self] movies, errorMessage in
            if let errorMessage = errorMessage {
                self?.error?(errorMessage)
            } else if let movies = movies {
                let listTitle = self?.getTitle(for: endpoint) ?? "Unknown"
                let movieModels = movies.map { movieData in
                    MovieBuilder()
                        .setId(movieData.id)
                        .setTitle(movieData.title)
                        .setPosterPath(movieData.posterPath)
                        .setBackdropPath(movieData.backdropPath)
                        .setOverview(movieData.overview)
                        .setReleaseDate(movieData.releaseDate)
                        .setLanguage(movieData.language)
                        .setPopularity(movieData.popularity)
                        .setRating(movieData.rating)
                        .setGenres(movieData.genres)
                        .setRuntime(movieData.runtime)
                        .setProductionCompanies(movieData.productionCompanies)
                        .build()
                }
                self?.items.append(.init(title: listTitle, movies: movieModels.compactMap { $0 }))
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
