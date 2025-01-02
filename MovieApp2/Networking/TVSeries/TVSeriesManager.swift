import Foundation

class TVSeriesManager {
    static func fetchSeries(endpoint: TVSeriesEndPoint, completion: @escaping ([TVSeries]?, String?) -> Void) {
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
}
