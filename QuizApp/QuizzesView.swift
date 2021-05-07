//
//  QuizzesView.swift
//  QuizApp
//
//  Created by Five on 13.04.2021..
//

import Foundation
import UIKit
import SnapKit

class QuizzesView: UIView {
    var label: UILabel!
    var button: UIButton!
    var funFactLabel: UILabel!
    var factTextLabel: UILabel!
    var errorLabel: UILabel!
    var errorMessageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .purple
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
        button.setTitle("Get Quiz", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(button)
        
        funFactLabel = UILabel()
        funFactLabel.text = "Fun Fact"
        funFactLabel.isHidden = true
        self.addSubview(funFactLabel)
        
        factTextLabel = UILabel()
        factTextLabel.text = ""
        factTextLabel.isHidden = true
        factTextLabel.numberOfLines = 0
        self.addSubview(factTextLabel)
        
        errorLabel = UILabel()
        errorLabel.text = "Error"
        self.addSubview(errorLabel)
        
        errorMessageLabel = UILabel()
        errorMessageLabel.text = """
Data can't be reached.
Please try again
"""
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.numberOfLines = 2
        self.addSubview(errorMessageLabel)
    }
    
    private func styleViews() {
        
        //self.backgroundColor = .clear
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        
        button.backgroundColor = .white
        button.isEnabled = true
        button.layer.cornerRadius = 20
        
        funFactLabel.textColor = .white
        funFactLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        factTextLabel.textColor = .white
        factTextLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        
        errorLabel.textColor = .white
        errorLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        
        errorMessageLabel.textColor = .white
        errorMessageLabel.font = UIFont.systemFont(ofSize: 17.0)
    }
    
    private func defineLayoutForViews() {
        button.snp.makeConstraints {
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
            $0.height.equalTo(40)
        }
        /*label.snp.makeConstraints {
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.centerY.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.2)
        }*/
        funFactLabel.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).offset(15)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
        }
        factTextLabel.snp.makeConstraints {
            $0.top.equalTo(funFactLabel.snp.bottom).offset(5)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
        errorLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        errorMessageLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(errorLabel.snp.bottom).offset(5)
        }
    }
}
