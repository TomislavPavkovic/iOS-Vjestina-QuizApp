//
//  QuizView.swift
//  QuizApp
//
//  Created by Five on 04.05.2021..
//

import Foundation
import UIKit
import SnapKit

class QuizView: UIView {
    var title: UILabel!
    var questionText: UILabel!
    var buttons = [UIButton]()
    var questionsTrackerView: QuestionTrackerView!
    
    init(text: String, answers: [String], questionsNum: Int) {
        super.init(frame: CGRect.init())
        createViews(text: text, answers: answers, questionsNum: questionsNum)
        styleViews()
        defineLayoutForViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refresh(text: String, answers: [String]){
        questionText.text = text
        var i = 0
        for answer in answers {
            buttons[i].setTitle(answer, for: .normal)
            i += 1
        }
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews(text: String, answers: [String], questionsNum: Int){
        title = UILabel()
        title.text = "PopQuiz"
        addSubview(title)
        questionText = UILabel()
        questionText.text = text
        addSubview(questionText)
        var i = 0
        for answer in answers {
            buttons.append(UIButton())
            buttons[i].setTitle(answer, for: .normal)
            addSubview(buttons[i])
            i += 1
        }
        questionsTrackerView = QuestionTrackerView(questionsNum: questionsNum)
        addSubview(questionsTrackerView)
    }
    func styleViews(){
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 30)
        questionText.textColor = .white
        questionText.font = UIFont.boldSystemFont(ofSize: 20)
        questionText.numberOfLines = 0
        for button in buttons {
            button.backgroundColor = .white.withAlphaComponent(0.4)
            button.setTitleColor(.white, for: .normal)
            button.isEnabled = true
            button.layer.cornerRadius = 20
        }
    }
    func defineLayoutForViews(){
        questionsTrackerView.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).offset(15)
            $0.height.equalTo(45)
            $0.width.equalToSuperview()
        }
        questionText.snp.makeConstraints{
            $0.top.equalTo(questionsTrackerView.snp.bottom).offset(20)
            $0.width.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.9)
            $0.centerX.equalToSuperview()
        }
        var i = 0
        for button in buttons {
            if (i == 0){
                button.snp.makeConstraints{
                    $0.top.equalTo(questionText.snp.bottom).offset(30)
                }
            } else {
                button.snp.makeConstraints{
                    $0.top.equalTo(buttons[i-1].snp.bottom).offset(15)
                }
            }
            i += 1
            button.snp.makeConstraints{
                $0.width.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.9)
                $0.height.equalTo(40)
                $0.centerX.equalToSuperview()
            }
        }
    }
}
