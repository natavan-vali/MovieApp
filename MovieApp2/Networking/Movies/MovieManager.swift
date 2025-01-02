//
//  MovieManager.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 24.10.24.
//

import Foundation

class MoviesManager {
    static func fetchMovies(endpoint: MoviesEndpoint, completion: @escaping ([Movie]?, String?) -> Void) {
        guard let url = endpoint.url else {
            completion(nil, "Invalid URL for endpoint \(endpoint)")
            return
        }
        
        NetworkManager.shared.fetch(urlString: url.absoluteString) { (result: MovieResponse?, errorMessage) in
            if let errorMessage = errorMessage {
                completion(nil, errorMessage)
                return
            }
            completion(result?.results, nil)
        }
    }
}

