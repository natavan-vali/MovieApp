import Foundation
import FirebaseAuth

struct User {
    var email: String
    var password: String
}

class AuthenticationService {
    static func loginUser(user: User, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = result {
                completion(.success(result))
            }
        }
    }
}

