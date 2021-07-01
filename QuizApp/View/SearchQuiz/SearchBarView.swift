//
//  SearchBarView.swift
//  QuizApp
//
//  Created by Five on 01.06.2021..
//

import Foundation
import UIKit
import SnapKit

class SearchBarView: UIView {
    var textField: UITextField!
    var searchButton: UIButton!
    
    init(){
        super.init(frame: CGRect.init())
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews() {
        textField = TextField()
        self.addSubview(textField)
        
        searchButton = UIButton()
        searchButton.setTitle("Search", for: .normal)
        self.addSubview(searchButton)
    }
    
    func styleViews() {
        textField.layer.cornerRadius = 20
        textField.layer.backgroundColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        textField.textColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 17.0)
        textField.attributedPlaceholder = NSAttributedString(string: "Type here", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.isEnabled = true
    }
    
    func defineLayoutForViews() {
        textField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(15)
            $0.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.75)
            $0.height.equalTo(40)
        }
        searchButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(textField.snp.trailing).offset(10)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-15)
            $0.height.equalTo(40)
        }
    }
}
