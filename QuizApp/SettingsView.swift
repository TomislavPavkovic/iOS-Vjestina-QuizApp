//
//  SettingsView.swift
//  QuizApp
//
//  Created by Five on 05.05.2021..
//

import Foundation
import UIKit
import SnapKit

class SettingsView: UIView {
    var usernameLabel: UILabel!
    var usernameContent: UILabel!
    var logOutButton: UIButton!
    
    init(frame: CGRect, username: String){
        super.init(frame: frame)
        createViews(username: username)
        styleViews()
        defineLayoutForViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews(username: String) {
        usernameLabel = UILabel()
        usernameLabel.text = "USERNAME"
        addSubview(usernameLabel)
        usernameContent = UILabel()
        usernameContent.text = username
        addSubview(usernameContent)
        logOutButton = UIButton()
        logOutButton.setTitle("Log Out", for: .normal)
        addSubview(logOutButton)
    }
    
    func styleViews() {
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        usernameLabel.textColor = .white
        usernameContent.font = UIFont.boldSystemFont(ofSize: 30)
        usernameContent.textColor = .white
        logOutButton.setTitleColor(.red, for: .normal)
        logOutButton.backgroundColor = .white
        logOutButton.layer.cornerRadius = 20
    }
    
    func defineLayoutForViews() {
        usernameLabel.snp.makeConstraints{
            $0.top.leading.equalTo(safeAreaLayoutGuide).offset(15)
        }
        usernameContent.snp.makeConstraints{
            $0.leading.equalTo(safeAreaLayoutGuide).offset(15)
            $0.top.equalTo(usernameLabel.snp.bottom).offset(5)
        }
        logOutButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-30)
            $0.height.equalTo(40)
        }
    }
}
