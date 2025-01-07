import Foundation

class TVSeriesManager {
    static let shared = TVSeriesManager()
    
    private init() {}
    
    func fetchSeries(endpoint: TVSeriesEndPoint, completion: @escaping ([TVSeries]?, String?) -> Void) {
        guard let url = endpoint.url else {
            completion(nil, "Invalid URL for endpoint \(endpoint)")
            return
        }
        
        NetworkManager.shared.fetch(urlString: url.absoluteString) { (result: TVSeriesResponse?, errorMessage) in
            if let errorMessage = errorMessage {
                completion(nil, errorMessage)
                return
            }
            completion(result?.results, nil)
        }
    }
    
    func fetchTVSeriesDetails(id: Int, completion: @escaping (TVSeries?, String?) -> Void) {
        let urlString = "\(NetworkConstants.baseURL)/tv/\(id)?api_key=\(NetworkConstants.apiKey)&language=en-US"
        
        guard URL(string: urlString) != nil else {
            completion(nil, "Invalid URL")
            return
        }
        
        NetworkManager.shared.fetch(urlString: urlString) { (result: TVSeries?, errorMessage) in
            if let errorMessage = errorMessage {
                completion(nil, errorMessage)
                return
            }
            
            guard let series = result else {
                completion(nil, "Series not found.")
                return
            }
            
            completion(series, nil)
        }
    }
}
