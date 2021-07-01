//
//  QuizNetworkDataSource.swift
//  QuizApp
//
//  Created by Five on 31.05.2021..
//

import Foundation

class QuizNetworkDataSource {
    private var networkService = NetworkService()
    
    func fetchQuizzes(completion:@escaping ([Quiz]?)->()) {
        
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
                return completion(value.quizzes)
            }
        }
    }
    
}
