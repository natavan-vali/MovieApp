import Foundation

protocol MediaUseCase {
    associatedtype MediaType
    func fetchMedia(endpoint: Endpoint, completion: @escaping ([MediaType]?, String?) -> Void)
    func fetchMediaDetails(id: Int, completion: @escaping (MediaType?, String?) -> Void)
}

protocol Endpoint {
    var url: URL? { get }
}

