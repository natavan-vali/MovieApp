import Foundation
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    func addFavorite(_ media: MediaData, _ userId: String, _ completion: @escaping (Error?) -> Void) {
        db.collection("favorites").addDocument(data: [
            "id": media.id,
            "userId": userId,
            "title": media.title,
            "type": media.type,
            "posterPath": media.posterURL,
            "createdAt": media.createdAt
        ], completion: completion)
    }
    
    func removeFavorite(_ mediaId: Int, _ userId: String, _ completion: @escaping (Error?) -> Void) {
        db.collection("favorites")
            .whereField("id", isEqualTo: mediaId)
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(error)
                } else {
                    snapshot?.documents.forEach { document in
                        document.reference.delete()
                    }
                    completion(nil)
                }
            }
    }
    
    func fetchFavorites(_ userId: String, _ completion: @escaping ([MediaData]?, Error?) -> Void) {
        db.collection("favorites")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(nil, error)
                } else {
                    let favorites: [MediaData] = snapshot?.documents.compactMap { doc in
                        let data = doc.data()
                        return MediaData(id: data["id"] as? Int ?? 0,
                                         title: data["title"] as? String ?? "",
                                         type: data["type"] as? String ?? "",
                                         posterURL: data["posterPath"] as? String ?? "",
                                         createdAt: data["createdAt"] as? Date ?? Date())
                    } ?? []
                    completion(favorites, nil)
                }
            }
    }
}
