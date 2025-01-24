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
    
            DispatchQueue.main.async {
                self.success?(seriesDetails)
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
