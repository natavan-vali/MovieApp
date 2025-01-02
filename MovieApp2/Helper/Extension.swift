//
//  Extension.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 24.10.24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(imageURL: String, placeholder: UIImage? = .init(named: "placeholder")) {
        guard let url = URL(string: imageURL) else {
            print("Invalid URL: \(imageURL)")
            return
        }
        
        self.kf.setImage(with: url, placeholder: placeholder, completionHandler: { result in
            switch result {
            case .success(_):
                return
            case .failure(let error):
                print("Error loading image: \(error.localizedDescription)")
            }
        })
    }
}

extension UIViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

