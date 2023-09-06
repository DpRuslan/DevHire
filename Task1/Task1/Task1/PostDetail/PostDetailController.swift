//
//  PostDetailController.swift
//

import UIKit
import CoreData.NSManagedObjectID

final class PostDetailController: UIViewController {
    var viewModel: PostDetailViewModel
    var tableView = UITableView(frame: .zero, style: .plain)
    private var commentsLabel = UILabel(frame: .zero)
    private var backButton = UIButton(frame: .zero)
    
    init(postId: NSManagedObjectID) {
        viewModel = PostDetailViewModel(postId: postId)
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        
        view.addSubview(commentsLabel)
        view.addSubview(backButton)
        view.addSubview(tableView)
        
        setupConstraints()
    }
}

extension PostDetailController {
    private func setupUI() {
        commentsLabel.text = viewModel.showAmountOfComments()
        commentsLabel.textColor = .white
        commentsLabel.font = UIFont.boldSystemFont(ofSize: 22)
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.setImage(viewModel.backImage, for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        
        tableView.register(PostDetailCell.self, forCellReuseIdentifier: "PostDetailCell")
        tableView.backgroundColor = UIColor(red: 72/255, green: 73/255, blue: 75/255, alpha: 0.55)
        tableView.dataSource = self
        tableView.layer.cornerRadius = 10
        tableView.separatorColor = UIColor.black
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension PostDetailController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            commentsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            commentsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.centerYAnchor.constraint(equalTo: commentsLabel.centerYAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: commentsLabel.bottomAnchor, constant: 10)
        ])
    }
}

extension PostDetailController {
    @objc func backButtonPressed(_ sender: Any) {
        viewModel.exitVC()
    }
}
