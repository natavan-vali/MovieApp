import Foundation

struct Person: Codable {
    let id: Int
    let name: String
    let profilePath: String?
    let biography: String?
    let birthday: String?
    let deathday: String?
    let placeOfBirth: String?
    
    var profileImageURL: URL? {
        guard let profilePath = profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, biography, birthday, deathday
        case profilePath = "profile_path"
        case placeOfBirth = "place_of_birth"
    }
}

struct PeopleResponse: Codable {
    let results: [Person]
}

