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
    private var quizzes: [[Quiz]]!
    private var catNum: Int = 0
    private var categories: [QuizCategory] = []
    private var cellId: Int = 0
    private var gradientLayer: CAGradientLayer!
    private var router: AppRouter!
    
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizzesView = QuizzesView()
        buildViews()
        quizzesView.button.addTarget(self , action: #selector(QuizzesViewController.buttonPressed(_:)), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        tableView?.backgroundColor = .clear
    }
    
    private func buildViews() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.purple.cgColor, CGColor(red: 0.20, green: 0.12, blue: 0.5, alpha: 1)]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
        view.addSubview(quizzesView)
        quizzesView.frame = view.bounds
        
        tabBarController?.navigationItem.titleView = quizzesView.label
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
        quizzesView.frame = view.bounds
    }
}

extension QuizzesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return catNum
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var cellConfig: UIListContentConfiguration = cell.defaultContentConfiguration()
        cellConfig.textProperties.color = .white
        cell.contentConfiguration = cellConfig
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        
        if (cell.subviews.filter{$0 is QuizField}.count == 0) {
            let field = QuizField(frame: self.accessibilityFrame, title: quizzes[indexPath.section][indexPath.row].title, desc: quizzes[indexPath.section][indexPath.row].description, lvl: quizzes[indexPath.section][indexPath.row].level, image: UIImage(named: "sport_quiz")!)
            cell.addSubview(field)
            field.snp.makeConstraints {
                $0.top.leading.equalToSuperview().offset(10)
                $0.bottom.trailing.equalToSuperview().offset(-10)
            }
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        returnedView.backgroundColor = .clear

        let label = UILabel(frame: CGRect(x: 10, y: 2, width: view.frame.size.width, height: 25))
        label.text = categories[section].rawValue
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        returnedView.addSubview(label)

        return returnedView
    }
    @objc func buttonPressed(_ button: UIButton) {
        quizzesView.errorLabel.isHidden = true
        quizzesView.errorMessageLabel.isHidden = true
        
        cellId = 0
        let quizzesTemp = DataService().fetchQuizes()
        categories = unique(source: quizzesTemp.map{$0.category})
        catNum = categories.count
        quizzes = Array(repeating: [], count: catNum)
        var index = 0
        for category in categories {
            quizzes[index].append(contentsOf: quizzesTemp.filter{$0.category == category})
            index += 1
        }
        
        if(tableView == nil){
            tableView = UITableView()
            tableView.frame = view.bounds
            view.addSubview(tableView)
            tableView.snp.makeConstraints{
                $0.top.equalTo(quizzesView.factTextLabel.snp.bottom).offset(15)
                $0.leading.equalTo(view.safeAreaLayoutGuide)
                $0.width.equalTo(view.safeAreaLayoutGuide)
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            tableView.delegate = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
            tableView.dataSource = self
            tableView.layer.backgroundColor = UIColor.clear.cgColor
            tableView.rowHeight = 150
        } else {
            tableView.reloadData()
        }
        
        
        quizzesView.funFactLabel.isHidden = false
        quizzesView.factTextLabel.text = String(format: "%@ %d %@", "There are", quizzesTemp.flatMap{$0.questions}
                    .filter{$0.question.contains("NBA")}
                    .count, "questions that contain the word NBA")
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

extension QuizzesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.showQuizViewController(quiz: quizzes[indexPath.section][indexPath.row])
    }
}
