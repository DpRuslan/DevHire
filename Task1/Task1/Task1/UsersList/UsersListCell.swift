//
//  UsersListCell.swift
//

import UIKit

final class UsersListCell: UITableViewCell {
    private var userNameLabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(userNameLabel)
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension UsersListCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            userNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            userNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25)
        ])
    }
}

extension UsersListCell {
    func configure(userName: String, userNickname: String) {
        userNameLabel.text = ("\(userName) (\(userNickname))")
        userNameLabel.textColor = .white
        userNameLabel.numberOfLines = 1
        userNameLabel.font = .boldSystemFont(ofSize: 16)
    }
}
