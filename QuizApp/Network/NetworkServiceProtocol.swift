//
//  NetwordServiceProtocol.swift
//  QuizApp
//
//  Created by Five on 15.05.2021..
//

import Foundation

protocol NetworkServiceProtocol {
    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping (Result<T, RequestError>) -> Void)
}
