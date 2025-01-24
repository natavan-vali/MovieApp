import UIKit

class TVSeriesDetailsViewModel {
    var selectedSeriesId: Int?
    var selectedSeries: TVSeries?
    var success: ((TVSeries) -> ())?
    var error: ((String) -> ())?
    
    private var favorites: [TVSeries] = []
    
    func fetchTVSeriesDetails() {
        TVSeriesManager.shared.fetchTVSeriesDetails(id: selectedSeriesId ?? 0) { seriesDetails, errorMessage in
            if let errorMessage = errorMessage {
                self.error?(errorMessage)
                return
            }
            
            guard let seriesDetails = seriesDetails else {
                self.error?("Series details are missing.")
                return
            }
    
            let series = TVSeriesBuilder()
                .setId(seriesDetails.id)
                .setTitle(seriesDetails.title)
                .setPosterPath(seriesDetails.posterPath)
                .setBackdropPath(seriesDetails.backdropPath)
                .setOverview(seriesDetails.overview)
                .setReleaseDate(seriesDetails.releaseDate)
                .setLanguage(seriesDetails.language)
                .setPopularity(seriesDetails.popularity)
                .setRating(seriesDetails.rating)
                .setGenres(seriesDetails.genres)
                .setRuntime(seriesDetails.runtime)
                .setProductionCompanies(seriesDetails.productionCompanies)
                .setNumberOfEpisodes(seriesDetails.numberOfEpisodes)
                .setNumberOfSeasons(seriesDetails.numberOfSeasons)
                .build()
            
            if let series = series {
                self.selectedSeries = series
                DispatchQueue.main.async {
                    self.success?(series)
                }
            } else {
                self.error?("Failed to create movie object.")
            }
        }
    }
    
    func isSeriesFavorite(completion: @escaping (Bool) -> Void) {
        guard let movieId = selectedSeriesId,
              let userId = AuthManager.shared.getCurrentUserId() else {
            completion(false)
            return
        }
        
        FireStoreManager.shared.checkMediaFavorite(mediaId: movieId, userId: userId, mediaType: "series") { isFavorite in
            completion(isFavorite)
        }
    }
}
