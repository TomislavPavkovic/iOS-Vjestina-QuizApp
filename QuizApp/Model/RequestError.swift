//
//  RequestError.swift
//  QuizApp
//
//  Created by Five on 15.05.2021..
//

import Foundation

enum RequestError: Error {
    case clientError
    case serverError
    case noDataError
    case decodingError
}
