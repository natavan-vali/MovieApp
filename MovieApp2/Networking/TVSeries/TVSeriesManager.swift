import Foundation

class TVSeriesManager: GenericMediaManager<TVSeries> {
    static let shared = TVSeriesManager()
    
    private override init() {}
    
    func fetchSeries(endpoint: TVSeriesEndPoint, completion: @escaping ([TVSeries]?, String?) -> Void) {
        fetchMedia(endpoint: endpoint, completion: completion)
    }
    
    func fetchTVSeriesDetails(id: Int, completion: @escaping (TVSeries?, String?) -> Void) {
        fetchMediaDetails(id: id, completion: completion)
    }

}

