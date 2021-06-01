//
//  CDQuestion+CoreDataProperties.swift
//  QuizApp
//
//  Created by Five on 01.06.2021..
//
//

import Foundation
import CoreData


extension CDQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuestion> {
        return NSFetchRequest<CDQuestion>(entityName: "CDQuestion")
    }

    @NSManaged public var identifier: Int32
    @NSManaged public var question: String?
    @NSManaged public var answers: NSObject?
    @NSManaged public var correctAnswer: Int32

}

extension CDQuestion : Identifiable {
    convenience init(question: Question) {
        self.init()
        identifier = Int32(question.id)
        self.question = question.question
        answers = question.answers as NSObject
        correctAnswer = Int32(question.correctAnswer)
    }
}
