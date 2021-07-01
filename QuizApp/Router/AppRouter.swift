//
//  AppRouter.swift
//  QuizApp
//
//  Created by Five on 04.05.2021..
//

import Foundation
import UIKit

class AppRouter: AppRouterProtocol {
    private let navigationController: UINavigationController!
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func setStartScreen(in window: UIWindow?) {
        let vc = LoginViewController(router: self)
        navigationController.pushViewController(vc, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func showQuizzesViewControllerAsRoot() {
        let coreDataContext = CoreDataStack(modelName: "QuizCD").managedContext
        let quizDatabaseDataSource = QuizDatabaseDataSource(coreDataContext: coreDataContext)
        let quizNetworkDataSource = QuizNetworkDataSource()
        let quizRepository = QuizRepository(networkDataSource: quizNetworkDataSource, databaseDataSource: quizDatabaseDataSource)
        
        let quizzesVC = QuizzesViewController(router: self, quizRepository: quizRepository)
        let searchQuizVC = SearchQuizViewController(router: self, quizRepository: quizRepository)
        quizzesVC.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(named: "quizzes-1.png"), selectedImage: UIImage(named: "quizzes.png"))
        searchQuizVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search-1.png"), selectedImage: UIImage(named: "search.png"))
        let settingsVC = SettingsViewController(router: self)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "Settings-1.png"), selectedImage: UIImage(named: "Settings.png"))
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [quizzesVC,searchQuizVC, settingsVC]
        navigationController.setViewControllers([tabBarController], animated: true)
    }
    func showQuizViewController(quiz: Quiz) {
        let vc = QuizViewController(router: self, quiz: quiz)
        navigationController.pushViewController(vc, animated: true)
    }
    func showQuizResultViewController(correct: Int, questionsNum: Int) {
        let vc = QuizResultViewController(router: self, correct: correct, questionsNum: questionsNum)
        navigationController.pushViewController(vc, animated: true)
    }
    func returnToRootViewController() {
        navigationController.popToRootViewController(animated: true)
    }
    func showLoginViewControllerAsRoot() {
        let vc = LoginViewController(router: self)
        navigationController.setViewControllers([vc], animated: true)
    }
}
