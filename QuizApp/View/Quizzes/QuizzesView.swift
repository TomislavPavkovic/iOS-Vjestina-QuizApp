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
    var funFactLabel: UILabel!
    var factTextLabel: UILabel!
    var errorLabel: UILabel!
    var errorMessageLabel: UILabel!
    
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
        funFactLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(10)
        }
        factTextLabel.snp.makeConstraints {
            $0.top.equalTo(funFactLabel.snp.bottom).offset(5)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
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
