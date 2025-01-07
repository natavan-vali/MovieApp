import Foundation

class LoginViewModel {
    

    var errorMessage: ((String) -> Void)?
    var navigateToMainTabBar: (() -> Void)?
    
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage?("Please fill in all fields.")
            return
        }
        
        AuthManager.shared.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.navigateToMainTabBar?()
            case .failure(let error):
                self?.errorMessage?(error.localizedDescription)
            }
        }
    }
}
