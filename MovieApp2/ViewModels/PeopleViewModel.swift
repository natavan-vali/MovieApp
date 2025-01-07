import Foundation

class PeopleViewModel {
    var people: [Person] = []
    var onPeopleUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchPopularPeople(page: Int) {
        PeopleManager.shared.fetchPopularPeople(page: page) { [weak self] results, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching people: \(error)")
                    self?.onError?(error)
                } else {
                    self?.people = results ?? []
                    self?.onPeopleUpdated?()
                }
            }
        }
    }
}
