import Foundation

class MovieBuilder {
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
    
    func setId(_ id: Int) -> MovieBuilder {
        self.id = id
        return self
    }
    
    func setTitle(_ title: String?) -> MovieBuilder {
        self.title = title
        return self
    }
    
    func setPosterPath(_ posterPath: String?) -> MovieBuilder {
        self.posterPath = posterPath
        return self
    }
    
    func setBackdropPath(_ backdropPath: String?) -> MovieBuilder {
        self.backdropPath = backdropPath
        return self
    }
    
    func setOverview(_ overview: String?) -> MovieBuilder {
        self.overview = overview
        return self
    }
    
    func setReleaseDate(_ releaseDate: String?) -> MovieBuilder {
        self.releaseDate = releaseDate
        return self
    }
    
    func setLanguage(_ language: String?) -> MovieBuilder {
        self.language = language
        return self
    }
    
    func setPopularity(_ popularity: Double?) -> MovieBuilder {
        self.popularity = popularity
        return self
    }
    
    func setRating(_ rating: Double?) -> MovieBuilder {
        self.rating = rating
        return self
    }
    
    func setGenres(_ genres: [Genre]?) -> MovieBuilder {
        self.genres = genres
        return self
    }
    
    func setRuntime(_ runtime: Int?) -> MovieBuilder {
        self.runtime = runtime
        return self
    }
    
    func setProductionCompanies(_ productionCompanies: [ProductionCompany]?) -> MovieBuilder {
        self.productionCompanies = productionCompanies
        return self
    }
    
    func build() -> Movie? {
        guard let id = id else { return nil }
        
        return Movie(id: id,
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
                     productionCompanies: productionCompanies)
    }
}
