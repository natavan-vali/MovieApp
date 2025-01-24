import Foundation

class TVSeriesBuilder {
    private var id: Int?
    private var title: String?
    private var posterPath: String?
    private var backdropPath: String?
    private var overview: String?
    private var releaseDate: String?
    private var language: String?
    private var popularity: Double?
    private var rating: Double?
    private var genres: [Genre]?
    private var runtime: Int?
    private var productionCompanies: [ProductionCompany]?
    private var numberOfSeasons: Int?
    private var numberOfEpisodes: Int?
    
    func setId(_ id: Int) -> TVSeriesBuilder {
        self.id = id
        return self
    }
    
    func setTitle(_ title: String?) -> TVSeriesBuilder {
        self.title = title
        return self
    }
    
    func setPosterPath(_ posterPath: String?) -> TVSeriesBuilder {
        self.posterPath = posterPath
        return self
    }
    
    func setBackdropPath(_ backdropPath: String?) -> TVSeriesBuilder {
        self.backdropPath = backdropPath
        return self
    }
    
    func setOverview(_ overview: String?) -> TVSeriesBuilder {
        self.overview = overview
        return self
    }
    
    func setReleaseDate(_ releaseDate: String?) -> TVSeriesBuilder {
        self.releaseDate = releaseDate
        return self
    }
    
    func setLanguage(_ language: String?) -> TVSeriesBuilder {
        self.language = language
        return self
    }
    
    func setPopularity(_ popularity: Double?) -> TVSeriesBuilder {
        self.popularity = popularity
        return self
    }
    
    func setRating(_ rating: Double?) -> TVSeriesBuilder {
        self.rating = rating
        return self
    }
    
    func setGenres(_ genres: [Genre]?) -> TVSeriesBuilder {
        self.genres = genres
        return self
    }
    
    func setRuntime(_ runtime: Int?) -> TVSeriesBuilder {
        self.runtime = runtime
        return self
    }
    
    func setProductionCompanies(_ productionCompanies: [ProductionCompany]?) -> TVSeriesBuilder {
        self.productionCompanies = productionCompanies
        return self
    }
    
    func setNumberOfSeasons(_ numberOfSeasons: Int?) -> TVSeriesBuilder {
        self.numberOfSeasons = numberOfSeasons
        return self
    }
    
    func setNumberOfEpisodes(_ numberOfEpisodes: Int?) -> TVSeriesBuilder {
        self.numberOfEpisodes = numberOfEpisodes
        return self
    }
    
    func build() -> TVSeries? {
        guard let id = id else { return nil }
        
        return TVSeries(id: id,
                        title: title,
                        posterPath: posterPath,
                        backdropPath: backdropPath,
                        overview: overview,
                        releaseDate: releaseDate,
                        language: language,
                        popularity: popularity,
                        rating: rating,
                        genres: genres,
                        runtime: runtime,
                        productionCompanies: productionCompanies,
                        numberOfSeasons: numberOfSeasons,
                        numberOfEpisodes: numberOfEpisodes)
    }
}
