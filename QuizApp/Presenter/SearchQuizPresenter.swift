//
//  SearchQuizPresenter.swift
//  QuizApp
//
//  Created by Five on 01.06.2021..
//

import Foundation

class SearchQuizPresenter {
    private var router: AppRouter!
    private var quizRepository: QuizRepository!
    
    init(router: AppRouter, quizRepository: QuizRepository){
        self.router = router
        self.quizRepository = quizRepository
    }
    
    func changeViewController(quiz: Quiz) {
        router.showQuizViewController(quiz: quiz)
    }
    
    func fetchQuizzes(searchText: String?) -> ([[Quiz]], [QuizCategory], Int) {
        let quizzes1D = quizRepository.fetchSearchedLocalData(searchText: searchText)
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
