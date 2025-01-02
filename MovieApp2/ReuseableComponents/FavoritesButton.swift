//
//  FavoritesButton.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 10.12.24.
//

import UIKit

class FavoritesButton: UIButton {
    
    var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        let heartImage = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
        
        let resizedImage = heartImage?.withTintColor(.red).resize(to: CGSize(width: 30, height: 28))
        
        setImage(resizedImage, for: .normal)
        setImage(resizedImage, for: .highlighted)

        frame = CGRect(x: 0, y: 0, width: 30, height: 28)
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        onTap?()
    }
}
