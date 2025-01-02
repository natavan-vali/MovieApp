import UIKit
import Alamofire

class MovieDetailsViewModel {
    var selectedMovieId: Int?
    var selectedMovie: Movie?
    var success: ((Movie) -> ())?
    var error: ((String) -> ())?
    
    private var favorites: [Movie] = []
    
    func fetchMovieDetails() {
        MovieDetailsManager.fetchMovieDetails(id: selectedMovieId ?? 0) { movieDetails, errorMessage in
            if let errorMessage = errorMessage {
                self.error?(errorMessage)
                return
            }
            
            guard let movieDetails = movieDetails else {
                self.error?("Movie details are missing.")
                return
            }
            
            DispatchQueue.main.async {
                self.success?(movieDetails)
            }
        }
    }
}
