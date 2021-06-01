//
//  Quiz+CD.swift
//  QuizApp
//
//  Created by Five on 31.05.2021..
//

import Foundation
import CoreData
import UIKit

extension Quiz {
    init(with entity: CDQuiz) {
        id = Int(entity.identifier)
        title = entity.title!
        description = entity.descriptionCD!
        category = QuizCategory(rawValue: entity.category!)!
        level = Int(entity.level)
        imageUrl = ""
        questions = entity.getQuestions()
        storedImageData = entity.image
    }
    func populate(_ entity: CDQuiz, in context: NSManagedObjectContext) {
        entity.identifier = Int32(id)
        entity.title = title
        entity.descriptionCD = description
        entity.category = category.rawValue
        entity.level = Int32(level)
        entity.image = try! Data(contentsOf: URL(string: imageUrl)!)
        /*var cdQestions: [CDQuestion] = []
        for question in questions {
            cdQestions.append(CDQuestion(question: question))
        }
        entity.questions = NSOrderedSet(array: questions)*/
    }
}


