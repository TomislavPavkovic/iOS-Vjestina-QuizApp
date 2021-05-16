//
//  NetwordServiceProtocol.swift
//  QuizApp
//
//  Created by Five on 15.05.2021..
//

import Foundation

protocol NetworkServiceProtocol {
    func executeUrlRequest(_ request: URLRequest, completionHandler: @escaping (Result<String, RequestError>) -> Void)
}
