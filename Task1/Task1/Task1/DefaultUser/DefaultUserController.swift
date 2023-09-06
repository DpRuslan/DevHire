//
//  DefaultUserController.swift
//

import UIKit
import Combine

final class DefaultUserController: UIViewController {
    var viewModel: DefaultUserViewModel
    private var cancellables: Set<AnyCancellable> = []
    var tableView = UITableView(frame: .zero, style: .plain)
    private var userNameLabel = UILabel(frame: .zero)
    private var usersListButton = UIButton(frame: .zero)
    
    init(userId: Int) {
        viewModel = DefaultUserViewModel(userId: userId)
        
        super.init(nibName: nil, bundle: nil)
        
        setupBinder()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        
        view.addSubview(userNameLabel)
        view.addSubview(usersListButton)
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.checkTrigger()
    }
}

extension DefaultUserController {
    private func setupUI() {
        userNameLabel.text = viewModel.showAuthorName()
        userNameLabel.textColor = .white
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        usersListButton.setImage(viewModel.usersListImage, for: .normal)
        usersListButton.addTarget(self, action: #selector(usersListButtonPressed(_:)), for: .touchUpInside)
        usersListButton.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(DefaultUserCell.self, forCellReuseIdentifier: "DefaultUserCell")
        tableView.backgroundColor = UIColor(red: 72/255, green: 73/255, blue: 75/255, alpha: 0.55)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 10
        tableView.separatorColor = UIColor.black
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension DefaultUserController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            
            usersListButton.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor),
            usersListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usersListButton.widthAnchor.constraint(equalToConstant: 27),
            usersListButton.heightAnchor.constraint(equalTo: usersListButton.widthAnchor, multiplier: 1),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10)
        ])
    }
}

extension DefaultUserController {
    @objc func usersListButtonPressed(_ sender: Any) {
        viewModel.showUsersList()
    }
}

extension DefaultUserController {
    private func setupBinder() {
        viewModel.eventPubisher.sink {[weak self] newName in
            self?.userNameLabel.text = newName
        }.store(in: &cancellables)
    }
}
