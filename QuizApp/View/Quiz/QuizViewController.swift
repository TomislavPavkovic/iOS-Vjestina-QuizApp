//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Five on 04.05.2021..
//

import Foundation
import UIKit
import SnapKit

class QuizViewController: UIViewController {
    private var router: AppRouter!
    private var gradientLayer: CAGradientLayer!
    private var quiz: Quiz!
    private var quizView: QuizView!
    private var question: Question!
    private var questionNum: Int = 0
    private var correct: Int = 0
    private var start: DispatchTime!
    private var presenter: QuizPresenter!
    
    convenience init(router: AppRouter, quiz: Quiz) {
        self.init()
        self.router = router
        self.quiz = quiz
        question = quiz.questions[questionNum]
        presenter = QuizPresenter(router: router)
        start = DispatchTime.now()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        for button in quizView.buttons {
            button.addTarget(self, action: #selector(QuizViewController.buttonPressed(_:)), for: .touchUpInside)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    private func buildViews() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.purple.cgColor, CGColor(red: 0.20, green: 0.12, blue: 0.5, alpha: 1)]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
        
        quizView = QuizView(frame: view.frame, text: question.question, answers: question.answers, questionsNum: quiz.questions.count)
        view.addSubview(quizView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
        quizView.frame = view.bounds
    }
    
    @objc func buttonPressed(_ button: UIButton){
        if (button.title(for: .normal) == question.answers[question.correctAnswer]) {
            button.backgroundColor = .green.withAlphaComponent(0.4)
            correct += 1
            quizView.questionsTrackerView.views[questionNum].backgroundColor = .green
        }
        else {
            quizView.buttons[question.correctAnswer].backgroundColor = .green.withAlphaComponent(0.4)
            button.backgroundColor = .red.withAlphaComponent(0.4)
            quizView.questionsTrackerView.views[questionNum].backgroundColor = .red
        }
        if (questionNum < quiz.questions.count-1){
            questionNum += 1
            question = quiz.questions[questionNum]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.quizView.refresh(text: self.question.question, answers: self.question.answers)
                self.quizView.questionsTrackerView.views[self.questionNum].alpha = 1
                self.quizView.questionsTrackerView.views[self.questionNum-1].alpha = 0.6
            }
        } else {
            let end = DispatchTime.now()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.presenter.sendResults(quizId: self.quiz.id, start: self.start, end: end, correct: self.correct)
                self.presenter.changeViewController(correct: self.correct, questionsNum: self.quiz.questions.count)
            }
        }
        
    }
}
