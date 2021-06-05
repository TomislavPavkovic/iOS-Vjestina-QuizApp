//
//  LoginPresenter.swift
//  QuizApp
//
//  Created by Five on 16.05.2021..
//

import Foundation
import Reachability

class LoginPresenter {
    private var networkService: NetworkServiceProtocol!
    private var router: AppRouter!
    private var reachability = Reachability(hostname: "https://iosquiz.herokuapp.com/api")
    
    init(router: AppRouter, networkService: NetworkServiceProtocol){
        self.router = router
        self.networkService = networkService
    }
    
    func login(username: String, password: String, completion:@escaping (LoginStatus?)->()) {
        if ((reachability?.isReachable()) != nil && reachability?.isReachable() == true) {
            guard let url = URL(string: "https://iosquiz.herokuapp.com/api/session?username=\(username)&password=\(password)") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            networkService.executeUrlRequest(request) { (result: Result<LoginResponse,
            RequestError>) in
                switch result {
                case .failure(let error):
                    print(error)
                    completion(.error(1, "Request error"))
                case .success(let value):
                    let userDefaults = UserDefaults.standard
                    userDefaults.set(value.token, forKey: "token")
                    userDefaults.set(value.userId, forKey: "userId")
                    completion(.success)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.25){
                        self.router.showQuizzesViewControllerAsRoot()
                    }
                }
            }
        }
        else {
            completion(.error(2, "No internet connection"))
        }
    }
    
}
