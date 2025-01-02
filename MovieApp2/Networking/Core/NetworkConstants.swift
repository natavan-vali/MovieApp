//
//  NetworkConstants.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 20.10.24.
//

import Foundation
import Alamofire

class NetworkConstants {
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiKey = "4cca7f13106bf39f3d0af6d96fffb3e5"
    static let language = "en-US"
    
    static func createURL(for type: String, endpoint: String) -> URL? {
        let urlString = "\(NetworkConstants.baseURL)/\(type)/\(endpoint)?api_key=\(NetworkConstants.apiKey)&language=\(NetworkConstants.language)&page=1"
        return URL(string: urlString)
    }
    
    static var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(NetworkConstants.apiKey)"
        ]
    }
}
