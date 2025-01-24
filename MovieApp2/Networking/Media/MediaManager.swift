import Foundation

struct ApiResponse<T: Codable>: Codable {
    var results: [T]?
    var totalResults: Int?
    var page: Int?
}

class GenericMediaManager<MediaType: Codable>: MediaUseCase {
    
    func fetchMedia(endpoint: Endpoint, completion: @escaping ([MediaType]?, String?) -> Void) {
        guard let url = endpoint.url else {
            completion(nil, "Invalid URL for endpoint \(endpoint)")
            return
        }
        
        NetworkManager.shared.fetch(urlString: url.absoluteString) { (result: ApiResponse<MediaType>?, errorMessage) in
            if let errorMessage = errorMessage {
                completion(nil, errorMessage)
                return
            }
            completion(result?.results, nil)
        }
    }
    
    func fetchMediaDetails(id: Int, completion: @escaping (MediaType?, String?) -> Void) {
        let mediaType: String
            if MediaType.self == TVSeries.self {
                mediaType = "tv"
            } else {
                mediaType = String(describing: MediaType.self).lowercased()  
            }
        
        let urlString = "\(NetworkConstants.baseURL)/\(mediaType)/\(id)?api_key=\(NetworkConstants.apiKey)&language=en-US"
        
        guard let url = URL(string: urlString) else {
            completion(nil, "Invalid URL")
            return
        }
        
        NetworkManager.shared.fetch(urlString: url.absoluteString) { (result: MediaType?, errorMessage) in
            if let errorMessage = errorMessage {
                completion(nil, errorMessage)
                return
            }
            
            guard let media = result else {
                completion(nil, "Media not found.")
                return
            }
            
            completion(media, nil)
        }
    }
}
