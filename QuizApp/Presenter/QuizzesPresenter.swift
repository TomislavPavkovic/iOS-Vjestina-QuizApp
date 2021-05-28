//
//  QuizzesPresenter.swift
//  QuizApp
//
//  Created by Five on 16.05.2021..
//

import Foundation

class QuizzesPresenter {
    private var networkService = NetworkService()
    private var router: AppRouter!
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func fetchQuizzes(completion:@escaping (([[Quiz]], [QuizCategory], Int)?)->()) {
        
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/quizzes") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(request) { (result: Result<QuizArray,
        RequestError>) in
            switch result {
            case .failure(let error):
                print(error)
                return completion(nil)
            case .success(let value):
                let categories = self.unique(source: value.quizzes.map{$0.category})
                let catNum = categories.count
                var quizzes:[[Quiz]] = Array(repeating: [], count: catNum)
                var index = 0
                for category in categories {
                    quizzes[index].append(contentsOf: value.quizzes.filter{$0.category == category})
                    index += 1
                }
                return completion((quizzes, categories, catNum))
            }
        }
    }
    
    func changeViewController(quiz: Quiz) {
        router.showQuizViewController(quiz: quiz)
    }
    
    func unique<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
        var buffer = [T]()
        var added = Set<T>()
        for elem in source {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
    
}
