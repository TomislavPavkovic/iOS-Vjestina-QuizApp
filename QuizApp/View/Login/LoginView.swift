//
//  LoginView.swift
//  QuizApp
//
//  Created by Five on 12.04.2021..
//

import Foundation
import UIKit
import SnapKit

class LoginView: UIView {
    var button: UIButton!
    private var label: UILabel!
    var emailField: UITextField!
    var passwordField: UITextField!
    var errorLabel: UILabel!
    var visibleButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        styleViews()
        defineLayoutForViews()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createViews() {
        
        label = UILabel()
        label.text = "PopQuiz"
        self.addSubview(label)
        
        button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        self.addSubview(button)
        
        emailField = TextField()
        passwordField = TextField()
        errorLabel = UILabel()
        self.addSubview(emailField)
        self.addSubview(passwordField)
        self.addSubview(errorLabel)
        
        visibleButton = UIButton()
        visibleButton.setImage(UIImage(named: "visibility_off"), for: .normal)
        self.addSubview(visibleButton)
    }
    
    private func styleViews() {
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40.0)
        
        button.backgroundColor = .white
        button.alpha = 0.6
        button.isEnabled = false
        button.layer.cornerRadius = 20
        
        emailField.layer.cornerRadius = 20
        emailField.layer.backgroundColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        emailField.textColor = .white
        emailField.font = UIFont.boldSystemFont(ofSize: 17.0)
        emailField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        
        passwordField.layer.backgroundColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        passwordField.textColor = .white
        passwordField.layer.cornerRadius = 20
        passwordField.font = UIFont.boldSystemFont(ofSize: 17.0)
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        passwordField.isSecureTextEntry = true
        
        errorLabel.isHidden = true;
        errorLabel.textColor = .white
        
        visibleButton.alpha = 0.8
    }
    
    private func defineLayoutForViews() {
        
        button.snp.makeConstraints {
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.8)
            $0.height.equalTo(40)
            $0.top.equalTo(passwordField.snp.bottom).offset(15)
        }
        label.snp.makeConstraints {
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.centerY.equalTo(emailField.snp.top).multipliedBy(0.5)
        }
        emailField.snp.makeConstraints {
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.8)
            $0.height.equalTo(40)
            $0.bottom.equalTo(passwordField.snp.top).offset(-15)
        }
        passwordField.snp.makeConstraints {
            $0.width.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.8)
            $0.height.equalTo(40)
            $0.center.equalTo(self.safeAreaLayoutGuide)
        }
        errorLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.8)
            $0.height.equalTo(40)
            $0.top.equalTo(button.snp.bottom).offset(15)
        }
        visibleButton.snp.makeConstraints {
            $0.trailing.equalTo(passwordField.snp.trailing).offset(-10)
            $0.height.equalTo(30)
            $0.centerY.equalTo(passwordField.snp.centerY)
            $0.width.equalTo(30)
        }
        
    }
}
