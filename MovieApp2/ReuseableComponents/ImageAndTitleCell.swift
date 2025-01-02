import UIKit

class ImageAndTitleCell: UITableViewCell {
    static let reuseIdentifier = "ImageAndTitleCell"
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.heightAnchor.constraint(equalToConstant: 130),
            
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        image.loadImage(imageURL: movie.posterURL)
    }
    
    func configure(with title: String, imageURL: URL?) {
            titleLabel.text = title
            if let imageUrl = imageURL {
                image.loadImage(imageURL: imageUrl.absoluteString)
            } else {
                image.image = UIImage(named: "placeholder")
            }
        }
}
