//
//  UsersListController.swift
//

import UIKit
import CoreData.NSManagedObjectID

final class UsersListController: UIViewController {
    var viewModel: UsersListViewModel
    var tableView = UITableView(frame: .zero, style: .plain)
    private var userNameLabel = UILabel(frame: .zero)
    private var backButton = UIButton(frame: .zero)
    
    init(userName: String) {
        viewModel = UsersListViewModel(userName: userName)
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(userNameLabel)
        view.addSubview(backButton)
        view.addSubview(tableView)
        
        setupConstraints()
    }
}

extension UsersListController {
    private func setupUI() {
        userNameLabel.text = viewModel.showAuthorName()
        userNameLabel.textColor = .white
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.setImage(viewModel.backImage, for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        
        tableView.register(UsersListCell.self, forCellReuseIdentifier: "UsersListCell")
        tableView.backgroundColor = UIColor(red: 72/255, green: 73/255, blue: 75/255, alpha: 0.55)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 10
        tableView.separatorColor = UIColor.black
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UsersListController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10)
        ])
    }
}

extension UsersListController {
    @objc func backButtonPressed(_ sender: Any) {
        viewModel.exitVC()
    }
}
