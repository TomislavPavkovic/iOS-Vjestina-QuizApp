//
//  QuizReslutViewController.swift
//  QuizApp
//
//  Created by Five on 05.05.2021..
//

import Foundation
import UIKit
import SnapKit

class QuizResultViewController: UIViewController {
    private var quizResultView: QuizResultView!
    private var gradientLayer: CAGradientLayer!
    private var correct: Int
    private var questionsNum: Int
    private var presenter: QuizResultPresenter!
    
    init(router: AppRouter, correct: Int, questionsNum: Int) {
        self.correct = correct
        self.questionsNum = questionsNum
        self.presenter = QuizResultPresenter(router: router)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.purple.cgColor, CGColor(red: 0.20, green: 0.12, blue: 0.5, alpha: 1)]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        quizResultView = QuizResultView(score: "\(correct)/\(questionsNum)")
        view.addSubview(quizResultView)
        
        quizResultView.finishButton.addTarget(self, action: #selector(QuizResultViewController.buttonPressed(_:)), for: .touchUpInside)
        
        quizResultView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    @objc func buttonPressed(_ button: UIButton){
        presenter.changeViewController()
    }
}
