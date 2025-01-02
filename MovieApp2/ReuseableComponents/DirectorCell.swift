//
//  DirectorCell.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 09.12.24.
//

import UIKit

class DirectorCell: UITableViewCell {
    private let directorTitleButton: UIButton = {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        button.setTitle("DIRECTOR", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let directorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func configure(with director: String) {
        directorLabel.text = director
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(directorTitleButton)
        contentView.addSubview(directorLabel)
        
        NSLayoutConstraint.activate([
            directorTitleButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            directorTitleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            directorTitleButton.widthAnchor.constraint(equalToConstant: 100),

            directorLabel.topAnchor.constraint(equalTo: directorTitleButton.topAnchor),
            directorLabel.leadingAnchor.constraint(equalTo: directorTitleButton.trailingAnchor, constant: 8),
            directorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            directorLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
