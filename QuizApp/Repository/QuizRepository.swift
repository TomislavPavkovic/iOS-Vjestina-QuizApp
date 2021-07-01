//
//  QuizRepository.swift
//  QuizApp
//
//  Created by Five on 31.05.2021..
//

import Foundation

class QuizRepository {
    private let networkDataSource: QuizNetworkDataSource!
    private let databaseDataSource: QuizDatabaseDataSource!
    
    init(networkDataSource: QuizNetworkDataSource, databaseDataSource: QuizDatabaseDataSource) {
        self.networkDataSource = networkDataSource
        self.databaseDataSource = databaseDataSource
    }
    
    func fetchRemoteData(competion: @escaping (([Quiz])->())) {
        networkDataSource.fetchQuizzes() {result in
            self.databaseDataSource.saveNewQuizzes(result!)
            competion(self.fetchLocalData())
        }
    }
    
    func fetchLocalData() -> [Quiz] {
        return databaseDataSource.fetchQuizzes()
    }
    
    func fetchSearchedLocalData(searchText: String?) -> [Quiz] {
        return databaseDataSource.fetchQuizzesFromCoreData(searchText: searchText)
    }
}
