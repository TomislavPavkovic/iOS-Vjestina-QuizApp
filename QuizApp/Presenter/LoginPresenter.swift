//
//  LoginPresenter.swift
//  QuizApp
//
//  Created by Five on 16.05.2021..
//

import Foundation

class LoginPresenter {
    private var networkService = NetworkService()
    private var router: AppRouter!
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func login(username: String, password: String, completion:@escaping (LoginStatus?)->()) {
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/session?username=\(username)&password=\(password)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(request) { (result: Result<LoginResponse,
        RequestError>) in
            switch result {
            case .failure(let error):
                print(error)
                return completion(.error(1, "Request error"))
            case .success(let value):
                let userDefaults = UserDefaults.standard
                userDefaults.set(value.token, forKey: "token")
                userDefaults.set(value.userId, forKey: "userId")
                self.router.showQuizzesViewControllerAsRoot()
                return completion(.success)
            }
        }
    }
    
}
