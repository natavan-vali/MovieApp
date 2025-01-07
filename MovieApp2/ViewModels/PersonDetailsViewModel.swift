import UIKit
import Alamofire

class PersonDetailsViewModel {
    var selectedPersonId: Int?
    var selectedPerson: Person?
    var success: ((Person) -> Void)?
    var error: ((String) -> Void)?
    
    func fetchPersonDetails() {
        PeopleManager.shared.fetchPersonDetails(id: selectedPersonId ?? 0) { personDetails, errorMessage in
            if let errorMessage = errorMessage {
                DispatchQueue.main.async {
                    self.error?(errorMessage)
                }
                return
            }
            
            guard let personDetails = personDetails else {
                DispatchQueue.main.async {
                    self.error?("Person details are missing.")
                }
                return
            }
            DispatchQueue.main.async {
                self.success?(personDetails)
            }
        }
    }
}
