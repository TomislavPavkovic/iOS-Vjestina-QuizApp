//
//  QuizPresenter.swift
//  QuizApp
//
//  Created by Five on 16.05.2021..
//

import Foundation

class QuizPresenter {
    private var networkService = NetworkService()
    private var router: AppRouter!
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func sendResults(quizId: Int, start: DispatchTime, end: DispatchTime, correct: Int) {
        let time = Double(end.uptimeNanoseconds - start.uptimeNanoseconds)/1000000000
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/result")
        else { return }
        let body: [String: Any] = ["quiz_id": quizId,
                                   "user_id": UserDefaults.standard.integer(forKey: "userId"),
                                   "time": time,
                                   "no_of_correct": correct]
        let bodyJson = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpBody = bodyJson
        request.httpMethod = "POST"
        request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(request) { (result: Result<ServerResponse, RequestError>) in
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let value):
                print(value)
            }
        }
    }
    func changeViewController(correct: Int, questionsNum: Int) {
        router.showQuizResultViewController(correct: correct, questionsNum: questionsNum)
    }
}
