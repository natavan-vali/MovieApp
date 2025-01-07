import Foundation

class FavoritesViewModel {
    var favorites: [MediaData] = []
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func addToFavorites(_ media: MediaData, _ userId: String) {
        FirebaseManager.shared.addFavorite(media, userId) { error in
            if let error = error {
                print("Error adding favorite: \(error.localizedDescription)")
                self.error?(error.localizedDescription)
            } else {
                self.favorites.append(media)
                self.success?()
            }
        }
    }
    
    func removeFromFavorites(_ media: MediaData, _ userId: String) {
        FirebaseManager.shared.removeFavorite(media.id, userId) { error in
            if let error = error {
                print("Error removing favorite: \(error.localizedDescription)")
                self.error?(error.localizedDescription)
            } else {
                self.favorites.removeAll { $0.id == media.id }
                self.success?()
            }
        }
    }
    
    func fetchFavorites(_ userId: String) {
        FirebaseManager.shared.fetchFavorites(userId) { favorites, error in
            if let error = error {
                print("Error fetching favorites: \(error.localizedDescription)")
                self.error?(error.localizedDescription)
            } else if let favorites = favorites {
                self.favorites = favorites
                self.success?()
            }
        }
    }
}
