import FirebaseFirestore
import FirebaseAuth

struct MediaData {
    var id: Int
    var title: String
    var type: String
    var posterURL: String
}

class FavoritesViewModel {
    private var db = Firestore.firestore()
    private var movieDetailsManager = MovieDetailsManager()
    var favorites: [MediaData] = []
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func addToFavorites(_ media: MediaData, _ userId: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        db.collection("favorites").addDocument(data: [
            "id": media.id,
            "userId": userId,
            "title": media.title,
            "type": media.type,
            "posterPath": media.posterURL
        ]) { error in
            if let error = error {
                print("Error adding favorite: \(error.localizedDescription)")
            }
        }
        
        favorites.append(media)
    }
    
    func removeFromFavorites(_ media: MediaData, _ userId: String) {
        db.collection("favorites")
            .whereField("id", isEqualTo: media.id)
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error removing favorite: \(error.localizedDescription)")
                } else {
                    snapshot?.documents.forEach { document in
                        document.reference.delete()
                    }
                    self.favorites.removeAll { $0.id == media.id }
                }
        }
    }
    
    func fetchFavorites(_ userId: String) {
        db.collection("favorites")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching favorites: \(error.localizedDescription)")
                } else {
                    self.favorites = snapshot?.documents.compactMap { doc in
                        let data = doc.data()
                        return MediaData(id: data["id"] as? Int ?? 0,
                                         title: data["title"] as? String ?? "",
                                         type: data["type"] as? String ?? "",
                                         posterURL: data["posterPath"] as? String ?? "")
                    } ?? []
                }
                
                DispatchQueue.main.async {
                    self.success?()
                }
            }
    }
}
