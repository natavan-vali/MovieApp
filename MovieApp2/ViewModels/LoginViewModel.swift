//
//  LoginViewModel.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 10.12.24.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    var email: String? {
        didSet {
            validateInput()
        }
    }
    
    var password: String? {
        didSet {
            validateInput()
        }
    }
    
    var errorMessage: String? {
        didSet {
            self.updateErrorMessage?()
        }
    }
    
    var isLoginEnabled: Bool = false {
        didSet {
            self.updateLoginButtonState?()
        }
    }
    
    var updateErrorMessage: (() -> Void)?
    var updateLoginButtonState: (() -> Void)?
    
    private func validateInput() {
        if let email = email, !email.isEmpty, let password = password, !password.isEmpty {
            isLoginEnabled = true
        } else {
            isLoginEnabled = false
        }
    }
    
    func login() {
        guard let email = email, let password = password else { return }
        let user = User(email: email, password: password)
        
        AuthenticationService.loginUser(user: user) { [weak self] result in
            switch result {
            case .success(_):
                self?.errorMessage = nil
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                
                if error.localizedDescription == "The email address is badly formatted." || error.localizedDescription.contains("user not found") {
                    self?.createUser(user: user)
                }
            }
        }
    }
    
    func createUser(user: User) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.errorMessage = nil
            }
        }
    }
}
