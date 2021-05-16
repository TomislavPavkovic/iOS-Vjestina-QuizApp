//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Five on 05.05.2021..
//

import Foundation
import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    private var settingsView: SettingsView!
    private var gradientLayer: CAGradientLayer!
    private var router: AppRouter!
    
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.purple.cgColor, CGColor(red: 0.20, green: 0.12, blue: 0.5, alpha: 1)]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        buildViews()
        
        settingsView.logOutButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
        settingsView.frame = view.bounds
    }
    
    func buildViews(){
        settingsView = SettingsView(frame: view.bounds, username: "Tomislav Pavković")
        view.addSubview(settingsView)
    }
    
    @objc func buttonPressed(_ button: UIButton){
        router.showLoginViewControllerAsRoot()
    }
}
