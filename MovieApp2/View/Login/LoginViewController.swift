//
//  LoginViewController.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 10.12.24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(LoginViewController.self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Account", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(LoginViewController.handleCreateAccount), for: .touchUpInside)
        return button
    }()
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        viewModel.errorMessage = { [weak self] message in
            self?.showErrorAlert(message: message)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            createAccountButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc private func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showErrorAlert(message: "Please fill in all fields.")
            return
        }
        
        viewModel.login(email: email, password: password)
    }
    
    @objc private func handleCreateAccount() {
        let createAccountVC = CreateAccountViewController()
        navigationController?.pushViewController(createAccountVC, animated: true)
    }
    
    func navigateToMainTabBar() {
        guard let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate else { return }
        let mainTabBarController = MainTabBarController()
        sceneDelegate.window?.rootViewController = mainTabBarController
    }
}
