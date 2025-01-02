import UIKit

class FavoritesButton: UIButton {
    
    var onTap: (() -> Void)?
    
    private var isFavorite: Bool = false {
        didSet {
            updateButtonState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateButtonState() {
        let filledHeartImage = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
        let emptyHeartImage = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
        
        let resizedFilledImage = filledHeartImage?.withTintColor(.red).resize(to: CGSize(width: 30, height: 28))
        let resizedEmptyImage = emptyHeartImage?.withTintColor(.red).resize(to: CGSize(width: 30, height: 28))
        
        setImage(isFavorite ? resizedFilledImage : resizedEmptyImage, for: .normal)
        setImage(isFavorite ? resizedFilledImage : resizedEmptyImage, for: .highlighted)
    }
    
    @objc private func didTap() {
        isFavorite.toggle()
        onTap?()
    }
    
    func setFavoriteState(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
        updateButtonState()
    }

    
    private func setupButton() {
        let heartImage = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
        let resizedImage = heartImage?.withTintColor(.red).resize(to: CGSize(width: 30, height: 28))
        
        setImage(resizedImage, for: .normal)
        setImage(resizedImage, for: .highlighted)

        frame = CGRect(x: 0, y: 0, width: 30, height: 28)
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
}
