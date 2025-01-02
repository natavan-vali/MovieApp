import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case requestFailed(Error)
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(urlString: String,
                             method: HTTPMethod = .get,
                             parameters: Parameters? = nil,
                             encoding: ParameterEncoding = URLEncoding.default,
                             completion: @escaping (T?, String?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL - \(urlString)")
            completion(nil, NetworkError.invalidURL.localizedDescription)
            return
        }
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: NetworkConstants.headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let decodedData):
                completion(decodedData, nil)
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
                if let data = response.data {
                    print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                }
                completion(nil, error.localizedDescription)
            }
        }
    }
}
