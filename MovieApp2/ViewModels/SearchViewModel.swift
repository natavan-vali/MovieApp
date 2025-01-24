import Foundation

class SearchViewModel {
    var movies: [Movie] = []
    var tvSeries: [TVSeries] = []
    var searchHistory: [String] = [] {
        didSet {
            saveSearchHistory()
        }
    }
    var onMoviesUpdated: (() -> Void)?
    var onTVSeriesUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init() {
        loadSearchHistory()
    }
    
    func search(query: String, type: SearchType) {
        switch type {
        case .movie:
            SearchManager.shared.searchItems(query: query, type: .movie) { [weak self] (response: MovieResponse?, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.onError?(error)
                    } else {
                        self?.movies = response?.results ?? []
                        self?.onMoviesUpdated?()
                    }
                }
            }
            
        case .tvSeries:
            SearchManager.shared.searchItems(query: query, type: .tvSeries) { [weak self] (response: TVSeriesResponse?, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.onError?(error)
                    } else {
                        self?.tvSeries = response?.results ?? []
                        self?.onTVSeriesUpdated?()
                    }
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

