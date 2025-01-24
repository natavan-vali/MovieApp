import UIKit

class MovieDetailsViewModel {
    var selectedMovieId: Int?
    var selectedMovie: Movie?
    var success: ((Movie) -> ())?
    var error: ((String) -> ())?
    
    private var favorites: [Movie] = []
    
    func fetchMovieDetails() {
        MoviesManager.shared.fetchMovieDetails(id: selectedMovieId ?? 0) { movieDetails, errorMessage in
            if let errorMessage = errorMessage {
                self.error?(errorMessage)
                return
            }
            
            guard let movieDetails = movieDetails else {
                self.error?("Movie details are missing.")
                return
            }
            
            let movie = MovieBuilder()
                .setId(movieDetails.id)
                .setTitle(movieDetails.title)
                .setPosterPath(movieDetails.posterPath)
                .setBackdropPath(movieDetails.backdropPath)
                .setOverview(movieDetails.overview)
                .setReleaseDate(movieDetails.releaseDate)
                .setLanguage(movieDetails.language)
                .setPopularity(movieDetails.popularity)
                .setRating(movieDetails.rating)
                .setGenres(movieDetails.genres)
                .setRuntime(movieDetails.runtime)
                .setProductionCompanies(movieDetails.productionCompanies)
                .build()
            
            if let movie = movie {
                self.selectedMovie = movie
                DispatchQueue.main.async {
                    self.success?(movie)
                }
            } else {
                self.error?("Failed to create movie object.")
            }
        }
    }
    
    func isMovieFavorite(completion: @escaping (Bool) -> Void) {
        guard let movieId = selectedMovieId,
              let userId = AuthManager.shared.getCurrentUserId() else {
            completion(false)
            return
        }
        
        FireStoreManager.shared.checkMediaFavorite(mediaId: movieId, userId: userId, mediaType: "movie") { isFavorite in
            completion(isFavorite)
        }
    }
    
}
