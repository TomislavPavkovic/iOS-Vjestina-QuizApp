//
//  QuizDatabaseDataSource.swift
//  QuizApp
//
//  Created by Five on 31.05.2021..
//

import Foundation
import CoreData

struct QuizDatabaseDataSource {
    private let coreDataContext: NSManagedObjectContext

    init(coreDataContext: NSManagedObjectContext) {
        self.coreDataContext = coreDataContext
    }
    
    func fetchQuizzes() -> [Quiz]{
        let request: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        do {
            return try coreDataContext.fetch(request).map { Quiz(with: $0) }
        } catch {
            print("Error when fetching quizzes from core data: \(error)")
            return []
        }
    }
    
    func fetchQuizzesFromCoreData(searchText: String?) -> [Quiz] {
        let request: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        var titlePredicate = NSPredicate(value: true)

        if let text = searchText, !text.isEmpty {
            titlePredicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(CDQuiz.title), text)
        }

        request.predicate = titlePredicate
        do {
            return try coreDataContext.fetch(request).map { Quiz(with: $0) }
        } catch {
            print("Error when fetching quizzes from core data: \(error)")
            return []
        }
    }
    
    func saveNewQuizzes(_ quizzes: [Quiz]) {
        do {
            let newIds = quizzes.map { $0.id }
            try deleteAllQuizzesExcept(withId: newIds)
        }
        catch {
            print("Error when deleting quizzes from core data: \(error)")
        }

        quizzes.forEach { quiz in
            
            do {
                let cdQuiz = try fetchQuiz(withId: quiz.id) ?? CDQuiz(context: coreDataContext)
                quiz.populate(cdQuiz, in: coreDataContext)
                
                do {
                    let newIds = quiz.questions.map { $0.id }
                    let idsToDelete = Quiz(with: cdQuiz).questions.map{ $0.id }.filter{!newIds.contains($0)}
                    try deleteQuestions(withId: idsToDelete)
                }
                catch {
                    print("Error when deleting questions from core data: \(error)")
                }
                quiz.questions.forEach { question in
                    do {
                        let cdQuestion = try fetchQuestion(withId: question.id) ?? CDQuestion(context: coreDataContext)
                        question.populate(cdQuestion, in: coreDataContext)
                        if (!Quiz(with: cdQuiz).questions.map{ $0.id }.contains(question.id)) {
                            cdQuiz.addToQuestions(cdQuestion)
                        }
                    } catch {
                        print("Error when fetching/creating a question: \(error)")
                    }
                }
            } catch {
                print("Error when fetching/creating a quiz: \(error)")
            }

            do {
                try coreDataContext.save()
            } catch {
                print("Error when saving updated quiz: \(error)")
            }
        }
    }

    private func fetchQuiz(withId id: Int) throws -> CDQuiz? {
        let request: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %u", #keyPath(CDQuiz.identifier), id)

        let cdResponse = try coreDataContext.fetch(request)
        return cdResponse.first
    }
    
    private func fetchQuestion(withId id: Int) throws -> CDQuestion? {
        let request: NSFetchRequest<CDQuestion> = CDQuestion.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %u", #keyPath(CDQuestion.identifier), id)

        let cdResponse = try coreDataContext.fetch(request)
        return cdResponse.first
    }
    
    private func deleteAllQuizzesExcept(withId ids: [Int]) throws {
        let request: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        request.predicate = NSPredicate(format: "NOT %K IN %@", #keyPath(CDQuiz.identifier), ids)

        let quizzesToDelete = try coreDataContext.fetch(request)
        quizzesToDelete.forEach { coreDataContext.delete($0) }
        try coreDataContext.save()
    }
    
    private func deleteQuestions(withId ids: [Int]) throws {
        let request: NSFetchRequest<CDQuestion> = CDQuestion.fetchRequest()
        request.predicate = NSPredicate(format: "%K IN %@", #keyPath(CDQuestion.identifier), ids)

        let questionsToDelete = try coreDataContext.fetch(request)
        questionsToDelete.forEach { coreDataContext.delete($0) }
        try coreDataContext.save()
    }
}

