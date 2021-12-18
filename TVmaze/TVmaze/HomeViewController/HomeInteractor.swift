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
    func getSeries()
    func infoAt(index: Int) -> HomeEntity
}

final class HomeInteractor: PresenterToInteractorHomeProtocol {
    // MARK: Properties
    private var series: [HomeEntity] = []
    weak var presenter: InteractorToPresenterHomeProtocol?

    var seriesCount: Int {
        return series.count
    }
    
    // MARK: Class methods
    func infoAt(index: Int) -> HomeEntity {
        return series[index]
    }
    
    func getSeries() {
        AF.request("https://api.tvmaze.com/shows")
            .validate().responseDecodable(of: [Series].self) { [weak self] (response) in
                switch response.result {
                case .success(let series):
                    self?.series = series.map { HomeEntity(series: $0) }
                    self?.presenter?.fetchSeriesSuccess()
                case .failure:
                    return
                }
            }
    }
}
