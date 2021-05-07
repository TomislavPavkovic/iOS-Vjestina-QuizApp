//
//  QuestionTrackerView.swift
//  QuizApp
//
//  Created by Five on 04.05.2021..
//

import Foundation
import UIKit
import SnapKit

class QuestionTrackerView: UIView {
    var views = [UIView]()
    
    init(frame: CGRect, questionsNum: Int){
        super.init(frame: frame)
        createViews(questionsNum: questionsNum)
        styleViews()
        defineLayoutForViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createViews(questionsNum: Int){
        for i in 0...questionsNum-1 {
            views.append(UIView())
            addSubview(views[i])
        }
    }
    func styleViews(){
        for view in views {
            view.backgroundColor = .white
            view.alpha = 0.6
            view.layer.cornerRadius = 2.5
        }
    }
    func defineLayoutForViews(){
        var index = 0
        for view in views{
            if (index == 0) {
                view.snp.makeConstraints{
                    $0.leading.equalTo(safeAreaLayoutGuide).offset(15)
                }
            } else if (index == views.count-1) {
                view.snp.makeConstraints{
                    $0.leading.equalTo(views[index-1].snp.trailing).offset(5)
                    $0.trailing.equalTo(safeAreaLayoutGuide).offset(-15)
                    $0.width.equalTo(views[0].snp.width)
                }
            } else {
                view.snp.makeConstraints{
                    $0.leading.equalTo(views[index-1].snp.trailing).offset(5)
                    $0.width.equalTo(views[0].snp.width)
                }
            }
            view.snp.makeConstraints{
                $0.top.equalTo(safeAreaLayoutGuide).offset(20)
                $0.height.equalTo(5)
                //$0.width.equalTo(safeAreaLayoutGuide).multipliedBy(1/views.count).offset(-5)
            }
            index += 1
        }
    }
}
