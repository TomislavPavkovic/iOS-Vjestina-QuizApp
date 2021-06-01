//
//  QuizzesPresenter.swift
//  QuizApp
//
//  Created by Five on 16.05.2021..
//

import Foundation
import Reachability

class QuizzesPresenter {
    private var router: AppRouter!
    private var quizRepository: QuizRepository!
    private var reachability = Reachability(hostname: "https://iosquiz.herokuapp.com/api")
    
    init(router: AppRouter, quizRepository: QuizRepository) {
        self.router = router
        self.quizRepository = quizRepository
    }
    
    func fetchQuizzes(completion: @escaping ((([[Quiz]], [QuizCategory], Int))->())) -> ([[Quiz]], [QuizCategory], Int)? {
        let quizzes1D = quizRepository.fetchLocalData()
        if ((reachability?.isReachable()) != nil && reachability?.isReachable() == true) {
            quizRepository.fetchRemoteData() { result in
                let categories = Array(Set(result.map{$0.category}))
                let catNum = categories.count
                var quizzes:[[Quiz]] = Array(repeating: [], count: catNum)
                var index = 0
                for category in categories {
                    quizzes[index].append(contentsOf: result.filter{$0.category == category})
                    index += 1
                }
                completion((quizzes, categories, catNum))
            }
        }
        if (quizzes1D.isEmpty) {
            return nil
        } else {
            let categories = Array(Set(quizzes1D.map{$0.category}))
            let catNum = categories.count
            var quizzes:[[Quiz]] = Array(repeating: [], count: catNum)
            var index = 0
            for category in categories {
                quizzes[index].append(contentsOf: quizzes1D.filter{$0.category == category})
                index += 1
            }
            return (quizzes, categories, catNum)
        }
    }
    
    func changeViewController(quiz: Quiz) {
        router.showQuizViewController(quiz: quiz)
    }
}
