//
//  SeriesAndEpisodes.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 10.12.24.
//

import UIKit

class SeasonAndEpisodesCell: UITableViewCell {
    private let seasonAndEpisodesButton: UIButton = {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        button.setTitle("S&E", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let seasonsAndEpisodesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    func configure(with duration: String) {
        seasonsAndEpisodesLabel.text = duration
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(seasonAndEpisodesButton)
        contentView.addSubview(seasonsAndEpisodesLabel)
        
        NSLayoutConstraint.activate([
            seasonAndEpisodesButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            seasonAndEpisodesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            seasonAndEpisodesButton.widthAnchor.constraint(equalToConstant: 100),

            seasonsAndEpisodesLabel.centerYAnchor.constraint(equalTo: seasonAndEpisodesButton.centerYAnchor),
            seasonsAndEpisodesLabel.leadingAnchor.constraint(equalTo: seasonAndEpisodesButton.trailingAnchor, constant: 8),
            seasonsAndEpisodesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            seasonsAndEpisodesLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
