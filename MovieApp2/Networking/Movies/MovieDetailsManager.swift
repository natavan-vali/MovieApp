//
//  MovieDetailsManager.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 19.11.24.
//

import Foundation

class MovieDetailsManager {
    static func fetchMovieDetails(id: Int, completion: @escaping (Movie?, String?) -> Void) {
        let urlString = "\(NetworkConstants.baseURL)/movie/\(id)?api_key=\(NetworkConstants.apiKey)&language=en-US"
        
        guard URL(string: urlString) != nil else {
            completion(nil, "Invalid URL")
            return
        }
        
        NetworkManager.shared.fetch(urlString: urlString) { (result: Movie?, errorMessage) in
            if let errorMessage = errorMessage {
                completion(nil, errorMessage)
                return
            }
            
            guard let movie = result else {
                completion(nil, "Movie not found.")
                return
            }
            
            completion(movie, nil)
        }
    }
}
