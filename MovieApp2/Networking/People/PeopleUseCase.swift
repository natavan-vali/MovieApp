import Foundation

protocol PeopleUseCase {
    func fetchPopularPeople(page: Int, completion: @escaping ([Person]?, String?) -> Void)
    func fetchPersonDetails(id: Int, completion: @escaping (Person?, String?) -> Void)
}
