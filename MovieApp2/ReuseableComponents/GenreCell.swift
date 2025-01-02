import UIKit

class GenreCell: UITableViewCell {
    private let genreTitleButton: UIButton = {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        button.setTitle("GENRE", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func configure(with genre: String) {
        genreLabel.text = genre
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(genreTitleButton)
        contentView.addSubview(genreLabel)
        
        NSLayoutConstraint.activate([
            genreTitleButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            genreTitleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            genreTitleButton.widthAnchor.constraint(equalToConstant: 100),

            genreLabel.centerYAnchor.constraint(equalTo: genreTitleButton.centerYAnchor),
            genreLabel.leadingAnchor.constraint(equalTo: genreTitleButton.trailingAnchor, constant: 8),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            genreLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
