//
//  HomeInteractor.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import Foundation
import Alamofire

protocol PresenterToInteractorHomeProtocol: AnyObject {
    var presenter: InteractorToPresenterHomeProtocol? { get set }
    var seriesCount: Int { get }
    var filteredSeriesCount: Int { get }
    func getSeries()
    func getFilteredSeries(string: String)
    func seriesInfoAt(index: Int) -> HomeEntity
    func filteredSeriesInfoAt(index: Int) -> HomeEntity
}

final class HomeInteractor: PresenterToInteractorHomeProtocol {
    // MARK: Properties
    private let seriesURL = "https://api.tvmaze.com/shows"
    private let seriesSearchURL = "https://api.tvmaze.com/search/shows"
    private var series: [HomeEntity] = []
    private var filteredSeries: [HomeEntity] = []
    weak var presenter: InteractorToPresenterHomeProtocol?

    var seriesCount: Int {
        return series.count
    }
    
    var filteredSeriesCount: Int {
        return filteredSeries.count
    }
    
    // MARK: Class methods
    func seriesInfoAt(index: Int) -> HomeEntity {
        return series[index]
    }
    
    func filteredSeriesInfoAt(index: Int) -> HomeEntity {
        return filteredSeries[index]
    }
    
    func getSeries() {
        AF.request(seriesURL)
            .validate().responseDecodable(of: [Series].self) { [weak self] (response) in
                switch response.result {
                case .success(let series):
                    self?.series = Array(series.prefix(20)).map { HomeEntity(series: $0) }
                    self?.presenter?.fetchSeriesSuccess()
                case .failure:
                    return
                }
            }
    }
    
    func getFilteredSeries(string: String) {
        let parameters: Parameters = ["q": string]
        AF.request(seriesSearchURL,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.queryString)
            .validate().responseDecodable(of: [FilteredSeries].self) { [weak self] (response) in
                switch response.result {
                case .success(let series) where series.isEmpty:
                    self?.filteredSeries = []
                    self?.presenter?.fetchFilteredSeriesSuccessZeroResults()
                case .success(let series):
                    self?.filteredSeries = series.map { HomeEntity(series: $0.series) }
                    self?.presenter?.fetchFilteredSeriesSuccessNonzeroResult()
                case .failure:
                    return
                }
            }
    }
}
