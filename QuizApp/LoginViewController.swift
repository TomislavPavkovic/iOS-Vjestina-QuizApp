//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Five on 10.04.2021..
//

import Foundation
import UIKit
import SnapKit


class LoginViewController: UIViewController {
    private var loginView: LoginView!
    private var gradientLayer: CAGradientLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.purple.cgColor, CGColor(red: 0.20, green: 0.12, blue: 0.5, alpha: 1)]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
        
        loginView = LoginView()
        loginView.passwordField.addTarget(self, action: #selector(LoginViewController.textFieldSelected(_:)), for: .editingDidBegin)
        loginView.emailField.addTarget(self, action: #selector(LoginViewController.textFieldSelected(_:)), for: .editingDidBegin)
        loginView.passwordField.addTarget(self, action: #selector(LoginViewController.textFieldNotSelected(_:)), for: .editingDidEnd)
        loginView.emailField.addTarget(self, action: #selector(LoginViewController.textFieldNotSelected(_:)), for: .editingDidEnd)
        loginView.passwordField.addTarget(self, action: #selector(LoginViewController.textFieldChanged(_:)), for: .editingChanged)
        loginView.emailField.addTarget(self, action: #selector(LoginViewController.textFieldChanged(_:)), for: .editingChanged)
        loginView.button.addTarget(self , action: #selector(LoginViewController.buttonPressed(_:)), for: .touchUpInside)
        loginView.visibleButton.addTarget(self, action: #selector(LoginViewController.visibilityChanged), for: .touchUpInside)
        buildViews()
    }
    private func buildViews() {
        view.addSubview(loginView)
        loginView.frame = view.frame
    }
    @objc func textFieldSelected(_ textField: TextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        loginView.errorLabel.isHidden = true
    }
    @objc func textFieldNotSelected(_ textField: TextField) {
        textField.layer.borderWidth = 0
    }
    @objc func textFieldChanged(_ textField: TextField) {
        if loginView.emailField.text != "" && loginView.passwordField.text != "" {
            loginView.button.alpha = 1
            loginView.button.isEnabled = true
        }
        else {
            loginView.button.alpha = 0.6
            loginView.button.isEnabled = false
        }
        loginView.errorLabel.isHidden = true
    }
    @objc func buttonPressed(_ button: UIButton) {
        let status = DataService().login(email: loginView.emailField.text!, password: loginView.passwordField.text!)
        switch status {
        case .success:
            print("Email: ", loginView.emailField.text!)
            print("Password: ", loginView.passwordField.text!)
        default:
            print(status)
            loginView.errorLabel.text = "Email or password is incorrect!"
            loginView.errorLabel.isHidden = false
        }
           
    }
    @objc func visibilityChanged(_ button: UIButton) {
        if loginView.passwordField.isSecureTextEntry == true {
            button.setImage(UIImage(named: "visibility_on"), for: .normal)
            loginView.passwordField.isSecureTextEntry = false
        } else {
            button.setImage(UIImage(named: "visibility_off"), for: .normal)
            loginView.passwordField.isSecureTextEntry = true
        }
    }
    

}
