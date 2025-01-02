//
//  DurationCell.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 09.12.24.
//

import UIKit

class DurationCell: UITableViewCell {
    private let durationTitleButton: UIButton = {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        button.setTitle("DURATION", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func configure(with duration: String) {
        durationLabel.text = duration
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(durationTitleButton)
        contentView.addSubview(durationLabel)
        
        NSLayoutConstraint.activate([
            durationTitleButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            durationTitleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            durationTitleButton.widthAnchor.constraint(equalToConstant: 100),

            durationLabel.centerYAnchor.constraint(equalTo: durationTitleButton.centerYAnchor),
            durationLabel.leadingAnchor.constraint(equalTo: durationTitleButton.trailingAnchor, constant: 8),
            durationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            durationLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

