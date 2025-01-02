import Foundation

class PeopleViewModel {
    private let peopleManager = PeopleManager()
    var people: [Person] = []
    var onPeopleUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchPopularPeople(page: Int) {
        peopleManager.fetchPopularPeople(page: page) { [weak self] results, error in
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
