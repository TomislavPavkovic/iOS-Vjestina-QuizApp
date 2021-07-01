//
//  Question+CD.swift
//  QuizApp
//
//  Created by Five on 31.05.2021..
//

import Foundation
import CoreData
import UIKit

extension Question {
    init(with entity: CDQuestion) {
        id = Int(entity.identifier)
        question = entity.question!
        answers = entity.answers as! [String]
        correctAnswer = Int(entity.correctAnswer)
    }
    
    func populate(_ entity: CDQuestion, in context: NSManagedObjectContext) {
        entity.identifier = Int32(self.id)
        entity.question = question
        entity.answers = answers as NSObject
        entity.correctAnswer = Int32(correctAnswer)
    }
}
