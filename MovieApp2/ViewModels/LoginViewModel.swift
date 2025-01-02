import Foundation
import FirebaseAuth

class LoginViewModel {
    

    var errorMessage: ((String) -> Void)?
    var navigateToMainTabBar: (() -> Void)?
    
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage?("Please fill in all fields.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage?(error.localizedDescription)
                return
            }
            self?.navigateToMainTabBar?()
        }
    }
}
