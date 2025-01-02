//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 22.11.24.
//

import Foundation

class SearchViewModel {
    private let searchManager = SearchManager()
    var movies: [Movie] = []
    var searchHistory: [String] = [] {
        didSet {
            saveSearchHistory()
        }
    }
    var onMoviesUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init() {
            loadSearchHistory()
        }
    
    func searchMovies(query: String) {
        searchManager.searchMovies(query: query) { [weak self] results, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.onError?(error)
                } else {
                    self?.movies = results ?? []
                    self?.onMoviesUpdated?()
                }
            }
        }
    }
    
    func addToSearchHistory(_ query: String) {
        guard !searchHistory.contains(query) else { return }
        searchHistory.append(query)
    }
    
    private func loadSearchHistory() {
            if let savedHistory = UserDefaults.standard.array(forKey: "searchHistory") as? [String] {
                searchHistory = savedHistory
            }
        }
        
        private func saveSearchHistory() {
            UserDefaults.standard.set(searchHistory, forKey: "searchHistory")
        }
}

