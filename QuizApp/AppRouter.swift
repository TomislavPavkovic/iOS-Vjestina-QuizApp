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
        let quizzesVC = QuizzesViewController(router: self)
        quizzesVC.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(named: "grid-three-up-24.png"), selectedImage: UIImage(named: "grud-three-up-24.png"))
        let settingsVC = SettingsViewController(router: self)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings-17-24.png"), selectedImage: UIImage(named: "settings-17-24.png"))
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [quizzesVC, settingsVC]
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
