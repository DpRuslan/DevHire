//
//  DefaultUserCell.swift
//

import UIKit

final class DefaultUserCell: UITableViewCell {
    private var titleLabel = UILabel(frame: .zero)
    private var bodyLabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        addSubview(bodyLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension DefaultUserCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            bodyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            bodyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            bodyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
}

extension DefaultUserCell {
    func configure(postName: String, postBody: String) {
        titleLabel.text = postName
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 1
        titleLabel.font = .boldSystemFont(ofSize: 16)
        
        bodyLabel.text = postBody
        bodyLabel.textColor = .white
        bodyLabel.numberOfLines = 2
        bodyLabel.font = .systemFont(ofSize: 16)
    }
}
