//
//  QuizResultView.swift
//  QuizApp
//
//  Created by Five on 05.05.2021..
//

import Foundation
import UIKit
import SnapKit

class QuizResultView: UIView {
    var result: UILabel!
    var finishButton: UIButton!
    
    init(score: String){
        super.init(frame: CGRect.init())
        createViews(score: score)
        styleViews()
        defineLayoutForViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews(score: String) {
        result = UILabel()
        result.text = score
        addSubview(result)
        finishButton = UIButton()
        finishButton.setTitle("Finish Quiz", for: .normal)
        addSubview(finishButton)
    }
    
    func styleViews() {
        result.font = UIFont.boldSystemFont(ofSize: 60)
        result.textColor = .white
        finishButton.setTitleColor(.purple, for: .normal)
        finishButton.backgroundColor = .white
        finishButton.layer.cornerRadius = 20
    }
    
    func defineLayoutForViews() {
        result.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        finishButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-30)
            $0.height.equalTo(40)
        }
    }
}
