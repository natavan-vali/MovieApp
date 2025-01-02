//
//  PersonDetailsViewModel.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 26.11.24.
//

import UIKit
import Alamofire

class PersonDetailsViewModel {
    var selectedPersonId: Int?
    var selectedPerson: Person?
    var success: ((Person) -> Void)?
    var error: ((String) -> Void)?
    
//    var profileURL: String = ""
//    var fullName: String = ""
//    var biography: String = ""
//    var birthInfo: String = ""
//    var deathInfo: String? = ""
    
    func fetchPersonDetails() {
//        guard let person = selectedPerson else {
//            DispatchQueue.main.async {
//                self.error?("Selected person is missing.")
//            }
//            return
//        }
        
        PeopleManager.fetchPersonDetails(id: selectedPersonId ?? 0) { personDetails, errorMessage in
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
            
//            self.profileURL = personDetails.profilePath.map { "https://image.tmdb.org/t/p/w500\($0)" } ?? ""
//            self.fullName = personDetails.name
//            self.biography = personDetails.biography ?? ""
//            
//            if let birthday = personDetails.birthday, let placeOfBirth = personDetails.placeOfBirth {
//                self.birthInfo = "\(self.fullName) was born on \(birthday) in \(placeOfBirth)."
//            } else {
//                self.birthInfo = "Birth information not available."
//            }
//            
//            self.deathInfo = personDetails.deathday.map { "\(self.fullName) passed away on \($0)." }
//            
            DispatchQueue.main.async {
                self.success?(personDetails)
            }
        }
    }
}
