//
//  QuizField.swift
//  QuizApp
//
//  Created by Five on 14.04.2021..
//

import Foundation
import UIKit
import SnapKit

class QuizField: UIView {
    var titleLabel: UILabel!
    var descLabel: UILabel!
    var lvlLabel: UILabel!
    var quizImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.backgroundColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.3)
        self.layer.cornerRadius = 20
        createViews(title: "Blank", desc: "Blank", lvl: 1, image: UIImage(named: "visibility_on")!)
        styleViews()
        defineLayoutForViews()
    }
    
    init(frame: CGRect, title: String, desc: String, lvl: Int, image: UIImage) {
        super.init(frame: frame)
        self.layer.backgroundColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.3)
        self.layer.cornerRadius = 20
        createViews(title: title, desc: desc, lvl: lvl, image: image)
        styleViews()
        defineLayoutForViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews(title: String, desc: String, lvl: Int, image: UIImage){
        titleLabel = UILabel()
        titleLabel.text = title
        descLabel = UILabel()
        descLabel.text = desc
        lvlLabel = UILabel()
        lvlLabel.text = String(format:"%@ %d", "Level:", lvl)
        quizImage = UIImageView(image: image)
        self.addSubview(titleLabel)
        self.addSubview(descLabel)
        self.addSubview(quizImage)
        self.addSubview(lvlLabel)
    }
    func styleViews(){
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        descLabel.textColor = .white
        descLabel.font = UIFont.boldSystemFont(ofSize: 15)
        descLabel.numberOfLines = 0
        titleLabel.textColor = .white
        lvlLabel.font = UIFont.boldSystemFont(ofSize: 12)
        lvlLabel.textColor = .cyan
        quizImage.layer.cornerRadius = 10
        quizImage.layer.masksToBounds = true
    }
    func defineLayoutForViews(){
        quizImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.height.equalTo(90)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(quizImage.snp.trailing).offset(20)
            $0.trailing.equalTo(lvlLabel.snp.leading).offset(-10)
            $0.top.equalToSuperview().offset(20)
        }
        descLabel.snp.makeConstraints {
            $0.leading.equalTo(quizImage.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.bottom.equalToSuperview().offset(-20)
        }
        lvlLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(10)
            $0.width.equalTo(50)
        }
        
    }
}
