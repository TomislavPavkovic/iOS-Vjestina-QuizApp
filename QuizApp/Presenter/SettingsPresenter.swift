//
//  SettingsPresenter.swift
//  QuizApp
//
//  Created by Five on 28.05.2021..
//

import Foundation

class SettingsPresenter {
    private var router: AppRouter!
    
    init(router: AppRouter){
        self.router = router
    }
    
    func changeViewController() {
        router.showLoginViewControllerAsRoot()
    }
    
}
