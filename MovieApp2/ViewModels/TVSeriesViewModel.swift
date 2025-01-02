//
//  TVSeriesViewModel.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 24.10.24.
//

import Foundation

struct TVSeriesListModel {
    let title: String
    let series: [TVSeries]
}

class TVSeriesViewModel {
    var items = [TVSeriesListModel]()
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func fetchTVSeries() {
        let endpoints: [TVSeriesEndPoint] = [.airingToday, .popular, .onTheAir, .topRated]
        
        for endpoint in endpoints {
            getSeriesItems(endpoint: endpoint)
        }
    }
    
    private func getSeriesItems(endpoint: TVSeriesEndPoint) {
        TVSeriesManager.fetchSeries(endpoint: endpoint) { [weak self] series, errorMessage in
            if let errorMessage = errorMessage {
                self?.error?(errorMessage)
            } else if let series = series {
                let listTitle = self?.getTitle(for: endpoint) ?? "Unknown"
                self?.items.append(.init(title: listTitle, series: series))
                self?.success?()
            }
        }
    }
    
    private func getTitle(for endpoint: TVSeriesEndPoint) -> String {
        switch endpoint {
        case .airingToday:
            return "Now Playing"
        case .onTheAir:
            return "Popular"
        case .popular:
            return "Top Rated"
        case .topRated:
            return "Upcoming"
        }
    }
}
