import Foundation

protocol SearchUseCase {
    func searchItems<T: Decodable>(query: String, type: SearchEndpoint, completion: @escaping (T?, String?) -> Void)
}
