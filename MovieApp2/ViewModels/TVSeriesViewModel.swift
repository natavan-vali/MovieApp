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
        TVSeriesManager.shared.fetchSeries(endpoint: endpoint) { [weak self] series, errorMessage in
            if let errorMessage = errorMessage {
                self?.error?(errorMessage)
            } else if let series = series {
                let listTitle = self?.getTitle(for: endpoint) ?? "Unknown"
                let seriesModels = series.map { seriesData in
                    TVSeriesBuilder()
                        .setId(seriesData.id)
                        .setTitle(seriesData.title)
                        .setPosterPath(seriesData.posterPath)
                        .setBackdropPath(seriesData.backdropPath)
                        .setOverview(seriesData.overview)
                        .setReleaseDate(seriesData.releaseDate)
                        .setLanguage(seriesData.language)
                        .setPopularity(seriesData.popularity)
                        .setRating(seriesData.rating)
                        .setGenres(seriesData.genres)
                        .setRuntime(seriesData.runtime)
                        .setProductionCompanies(seriesData.productionCompanies)
                        .setNumberOfSeasons(seriesData.numberOfSeasons)
                        .setNumberOfEpisodes(seriesData.numberOfEpisodes)
                        .build()
                }
                self?.items.append(.init(title: listTitle, series: seriesModels.compactMap { $0 }))
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
