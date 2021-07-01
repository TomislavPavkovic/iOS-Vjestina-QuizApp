//
//  SearchViewController.swift
//  QuizApp
//
//  Created by Five on 01.06.2021..
//

import Foundation
import UIKit
import SnapKit

class SearchQuizViewController: UIViewController {
    private var searchBarView: SearchBarView!
    private var gradientLayer: CAGradientLayer!
    private var router: AppRouter!
    private var presenter: SearchQuizPresenter!
    private var tableView: UITableView!
    private let cellIdentifier = "cellId"
    private var quizzes: [[Quiz]]!
    private var catNum: Int = 0
    private var categories: [QuizCategory] = []
    private var cellId: Int = 0
    
    convenience init(router: AppRouter, quizRepository: QuizRepository) {
        self.init()
        presenter = SearchQuizPresenter(router: router, quizRepository: quizRepository)
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
        
        searchBarView.searchButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        searchBarView.textField.addTarget(self, action: #selector(textFieldSelected(_:)), for: .editingDidBegin)
        searchBarView.textField.addTarget(self, action: #selector(textFieldNotSelected(_:)), for: .editingDidEnd)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        tableView?.backgroundColor = .clear
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    func buildViews(){
        searchBarView = SearchBarView()
        view.addSubview(searchBarView)
        searchBarView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(50)
        }
    }
    
    @objc func textFieldSelected(_ textField: TextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
    }
    @objc func textFieldNotSelected(_ textField: TextField) {
        textField.layer.borderWidth = 0
    }
    
}
extension SearchQuizViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.changeViewController(quiz: quizzes[indexPath.section][indexPath.row])
    }
}

extension SearchQuizViewController: UITableViewDataSource {
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
    
    @objc func buttonPressed(_ button: UIButton){
        let result = presenter.fetchQuizzes(searchText: searchBarView.textField.text)
        quizzes = result.0
        categories = result.1
        catNum = result.2
        if (tableView == nil) {
            tableView = UITableView()
            tableView.frame = view.bounds
            view.addSubview(tableView)
            tableView.snp.makeConstraints{
                $0.top.equalTo(searchBarView.textField.snp.bottom).offset(15)
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
    }
}
