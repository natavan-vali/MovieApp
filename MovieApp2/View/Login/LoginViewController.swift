//
//  LoginViewController.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 10.12.24.
//

import UIKit

class LoginViewController: UIViewController {
    
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var viewModel: LoginViewModel!
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LoginViewModel()
        viewModel.updateErrorMessage = { [weak self] in
            self?.showErrorAlert(message: self?.viewModel.errorMessage ?? "Unknown error")
        }
        viewModel.updateLoginButtonState = { [weak self] in
            self?.loginButton.isEnabled = self?.viewModel.isLoginEnabled ?? false
        }
        
        setupUI()
        registerForKeyboardNotifications()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        scrollView = UIScrollView(frame: view.bounds)
            scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 200) // Kontentin ölçüsünü artırın
            view.addSubview(scrollView)

            // İçərisində bir UIView yaradın
            let contentView = UIView(frame: scrollView.bounds)
            scrollView.addSubview(contentView)
        
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.addTarget(self, action: #selector(emailTextChanged), for: .editingChanged)
        contentView.addSubview(emailTextField)
        
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(passwordTextChanged), for: .editingChanged)
        contentView.addSubview(passwordTextField)
        
//        errorLabel = UILabel()
//        errorLabel.textColor = .red
//        errorLabel.textAlignment = .center
//        errorLabel.isHidden = true
//        contentView.addSubview(errorLabel)
//        
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 5
        loginButton.isEnabled = false
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        contentView.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let screenWidth = view.bounds.size.width
        
        emailTextField.frame = CGRect(x: 20, y: 150, width: screenWidth - 40, height: 40)
        passwordTextField.frame = CGRect(x: 20, y: 210, width: screenWidth - 40, height: 40)
//        errorLabel.frame = CGRect(x: 20, y: 270, width: screenWidth - 40, height: 40)
        loginButton.frame = CGRect(x: 20, y: 320, width: screenWidth - 40, height: 50)
    }
    
    @objc private func emailTextChanged() {
        if let email = emailTextField.text, isValidEmail(email) {
            viewModel.email = email
        } else {
            viewModel.email = nil
        }
    }
    
    @objc private func passwordTextChanged() {
        viewModel.password = passwordTextField.text
    }
    
    @objc private func loginButtonTapped() {
        viewModel.login()
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            scrollView.scrollIndicatorInsets = scrollView.contentInset
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
