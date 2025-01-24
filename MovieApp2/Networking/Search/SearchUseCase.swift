import Foundation

protocol SearchUseCase {
    func searchItems<T: Decodable>(query: String, type: SearchType, completion: @escaping (T?, String?) -> Void)
}

enum SearchType {
    case movie
    case tvSeries
}
