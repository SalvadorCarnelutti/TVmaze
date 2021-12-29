//
//  PeopleSearchInteractor.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

import Alamofire

protocol PresenterToInteractorPeopleSearchProtocol: AnyObject {
    var presenter: InteractorToPresenterPeopleSearchProtocol? { get set }
    var peopleCount: Int { get }
    func getFilteredPeople(string: String)
    func personInfoAt(indexPath: IndexPath) -> PersonEntity
}

final class PeopleSearchInteractor: PresenterToInteractorPeopleSearchProtocol {
    weak var presenter: InteractorToPresenterPeopleSearchProtocol?
    private let peopleSearchURL = "https://api.tvmaze.com/search/people"
    private var people: [PersonEntity] = []
        
    var peopleCount: Int {
        return people.count
    }
    
    func getFilteredPeople(string: String) {
        let parameters: Parameters = ["q": string]
        AF.request(peopleSearchURL,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.queryString)
            .validate()
            .responseDecodable(of: [PersonEntity].self) { [weak self] (response) in
                switch response.result {
                case .success(let people) where people.isEmpty:
                    self?.people = []
                    self?.presenter?.onFetchFilteredPeopleSuccessZeroResults()
                case .success(let people):
                    self?.people = people.filter { $0.personImageURL != nil }
                    self?.people += people.filter { $0.personImageURL == nil }
                    self?.presenter?.onFetchFilteredPeopleSuccessNonzeroResult()
                case .failure:
                    self?.presenter?.onFetchPeopleFailure()
                }
            }
    }
    
    func personInfoAt(indexPath: IndexPath) -> PersonEntity {
        return people[indexPath.row]
    }
}
