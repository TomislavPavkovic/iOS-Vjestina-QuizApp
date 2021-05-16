//
//  ServerResponse.swift
//  QuizApp
//
//  Created by Five on 16.05.2021..
//

import Foundation

struct ServerResponse: Codable {
    var error: ServerResponseEnum?
}

enum ServerResponseEnum: Int, Codable{
    case unathorized
    case forbidden
    case notFound
    case badRequest
    case ok
}
