import UIKit

class InfoCell: UITableViewCell {
    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let languageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "globe")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let popularityIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configure(language: String, popularity: String, rating: String) {
        languageLabel.text = language
        popularityLabel.text = popularity
        ratingLabel.text = rating
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let languageStack = UIStackView(arrangedSubviews: [languageIcon, languageLabel])
        languageStack.axis = .horizontal
        languageStack.spacing = 5
        languageStack.alignment = .center
        
        let popularityStack = UIStackView(arrangedSubviews: [popularityIcon, popularityLabel])
        popularityStack.axis = .horizontal
        popularityStack.spacing = 5
        popularityStack.alignment = .center
        
        let ratingStack = UIStackView(arrangedSubviews: [ratingIcon, ratingLabel])
        ratingStack.axis = .horizontal
        ratingStack.spacing = 5
        ratingStack.alignment = .center
        
        infoStack.addArrangedSubview(languageStack)
        infoStack.addArrangedSubview(popularityStack)
        infoStack.addArrangedSubview(ratingStack)
        
        contentView.addSubview(infoStack)
        
        NSLayoutConstraint.activate([
            infoStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            infoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            infoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            infoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
