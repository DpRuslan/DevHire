//
//  PostDetailCell.swift
//

import UIKit

final class PostDetailCell: UITableViewCell {
    private var emailLabel = UILabel(frame: .zero)
    private var bodyLabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(emailLabel)
        addSubview(bodyLabel)
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension PostDetailCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            emailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            emailLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            bodyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            bodyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            bodyLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            bodyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
}

extension PostDetailCell {
    func configure(email: String, commentBody: String) {
        emailLabel.text = email
        emailLabel.textColor = .white
        emailLabel.numberOfLines = 1
        emailLabel.font = .boldSystemFont(ofSize: 16)
        
        bodyLabel.text = commentBody
        bodyLabel.textColor = .white
        bodyLabel.numberOfLines = 2
        bodyLabel.font = .systemFont(ofSize: 16)
    }
}
