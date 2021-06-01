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
    private var presenter: QuizzesPresenter!
    
    convenience init(router: AppRouter, quizRepository: QuizRepository) {
        self.init()
        presenter = QuizzesPresenter(router: router, quizRepository: quizRepository)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizzesView = QuizzesView()
        buildViews()
        quizzesView.errorLabel.isHidden = true
        quizzesView.errorMessageLabel.isHidden = true
        
        cellId = 0
        let result = presenter.fetchQuizzes() { [self] res in
            quizzes = res.0
            categories = res.1
            catNum = res.2
            DispatchQueue.main.async{
                self.tableView.reloadData()
                view.layoutIfNeeded()
            }
            quizzesView.factTextLabel.text = String(format: "%@ %d %@", "There are", quizzes.flatMap{$0}.flatMap{$0.questions}
                        .filter{$0.question.contains("NBA")}
                        .count, "questions that contain the word NBA")
        }
        quizzes = result?.0 ?? [[]]
        categories = result?.1 ?? []
        catNum = result?.2 ?? 0
        
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
    
        quizzesView.funFactLabel.isHidden = false
        quizzesView.factTextLabel.text = String(format: "%@ %d %@", "There are", quizzes.flatMap{$0}.flatMap{$0.questions}
                    .filter{$0.question.contains("NBA")}
                    .count, "questions that contain the word NBA")
        quizzesView.factTextLabel.isHidden = false
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
        quizzesView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        tabBarController?.navigationItem.titleView = quizzesView.label
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
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
        
        
        cell.subviews.forEach { $0.removeFromSuperview() }
        
        let field = QuizField(frame: self.accessibilityFrame, title: quizzes[indexPath.section][indexPath.row].title, desc: quizzes[indexPath.section][indexPath.row].description, lvl: quizzes[indexPath.section][indexPath.row].level, image: ((UIImage(data: quizzes[indexPath.section][indexPath.row].storedImageData ?? Data()) ?? UIImage(named: "sport_quiz"))!))
        cell.addSubview(field)
        field.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.bottom.trailing.equalToSuperview().offset(-10)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].rawValue
    }
    
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
}

extension QuizzesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.changeViewController(quiz: quizzes[indexPath.section][indexPath.row])
    }
}
