import Foundation

class PeopleManager: PeopleUseCase {
    static let shared = PeopleManager()
    
    private init() {}
    
    func fetchPopularPeople(page: Int, completion: @escaping ([Person]?, String?) -> Void) {
        guard let url = PeopleEndpoint.popular.url else {
            completion(nil, "Invalid URL")
            return
        }
        
        let parameters: [String: Any] = [
            "page": page
        ]
        
        NetworkManager.shared.fetch(urlString: url.absoluteString, parameters: parameters) { (response: PeopleResponse?, error) in
            if let error = error {
                completion(nil, error)
            } else {
                completion(response?.results, nil)
            }
        }
    }
    
    func fetchPersonDetails(id: Int, completion: @escaping (Person?, String?) -> Void) {
        guard let url = PeopleEndpoint.personDetails.detailsURL(for: id) else {
            completion(nil, "Invalid URL")
            return
        }
        
        NetworkManager.shared.fetch(urlString: url.absoluteString) { (result: Person?, errorMessage) in
            if let errorMessage = errorMessage {
                completion(nil, errorMessage)
                return
            }
            
            guard let personDetails = result else {
                completion(nil, "Person details not found.")
                return
            }
            
            completion(personDetails, nil)
        }
    }
}
