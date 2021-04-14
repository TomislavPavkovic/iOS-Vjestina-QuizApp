//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Five on 13.04.2021..
//

import Foundation
import UIKit

class QuizzesViewController: UIViewController {
    private var tableView: UITableView!
    private var quizzesView: QuizzesView!
    private let cellIdentifier = "cellId"
    private var quizzes: [Quiz] = []
    private var catNum: Int = 0
    private var categories: [QuizCategory] = []
    private var cellId: Int = 0
    private var gradientLayer: CAGradientLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        quizzesView = QuizzesView()
        buildViews()
        quizzesView.button.addTarget(self , action: #selector(QuizzesViewController.buttonPressed(_:)), for: .touchUpInside)
    }
    private func buildViews() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.purple.cgColor, CGColor(red: 0.20, green: 0.12, blue: 0.5, alpha: 1)]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
        view.addSubview(quizzesView)
        quizzesView.frame = view.frame
        
    }
}

extension QuizzesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return catNum
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.filter{$0.category == categories[section]}.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell  = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var cellConfig: UIListContentConfiguration = cell.defaultContentConfiguration()
        cellConfig.textProperties.color = .white
        cell.contentConfiguration = cellConfig
        cell.backgroundColor = .clear
        
        let quizField = QuizField(frame: self.accessibilityFrame, title: quizzes[cellId].title, desc: quizzes[cellId].description, lvl: quizzes[cellId].level, image: UIImage(named: "sport_quiz")!)
        if cellId<catNum {
            cellId+=1
        }
        cell.addSubview(quizField)
        quizField.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.bottom.trailing.equalToSuperview().offset(-10)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].rawValue
    }
    
    //neuspješan pokušaj mijenjanja boje section header-a
    /*func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            let header = view as! UITableViewHeaderFooterView
            header.backgroundView?.backgroundColor = .clear
            header.textLabel?.textColor = .white
    }*/
    
    @objc func buttonPressed(_ button: UIButton) {
        quizzesView.errorLabel.isHidden = true
        quizzesView.errorMessageLabel.isHidden = true
        
        cellId = 0
        quizzes = DataService().fetchQuizes()
        categories = unique(source: quizzes.map{$0.category})
        catNum = categories.count
        
        tableView = UITableView(
            frame: CGRect(
                x: 0,
                y: 320,
                width: view.bounds.width,
                height: view.bounds.height
            )
        )
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.rowHeight = 150
        
        quizzesView.funFactLabel.isHidden = false
        quizzesView.factTextLabel.text = String(format: "%@ %d %@", "There are", quizzes.flatMap{$0.questions}.filter{$0.question.contains("NBA")}.count, "questions that contain the word NBA")
        quizzesView.factTextLabel.isHidden = false
    }
    
    //funkcija unique preuzeta sa stackoverflow-a
    func unique<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
        var buffer = [T]()
        var added = Set<T>()
        for elem in source {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}

