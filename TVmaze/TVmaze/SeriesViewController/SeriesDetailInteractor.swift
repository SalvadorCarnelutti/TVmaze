//
//  SeriesDetailInteractor.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

import Alamofire

protocol PresenterToInteractorSeriesDetailProtocol: AnyObject {
    var presenter: InteractorToPresenterSeriesDetailProtocol? { get set }
    var numberOfSections: Int { get }
    func getEpisodes()
    func seriesDetailAt(indexPath: IndexPath) -> SeriesDetailEntity
    func episodesCountAt(section: Int) -> Int
}

final class SeriesDetailInteractor: PresenterToInteractorSeriesDetailProtocol {
    // MARK: Properties
    private static let seriesEpisodesURL = "https://api.tvmaze.com/shows"
    private var seriesSeasonsBucket: [[SeriesDetailEntity]] = []
    weak var presenter: InteractorToPresenterSeriesDetailProtocol?

    var numberOfSections: Int {
        return seriesSeasonsBucket.count
    }
    
    // MARK: Class methods
    func seriesDetailAt(indexPath: IndexPath) -> SeriesDetailEntity {
        return seriesSeasonsBucket[indexPath.section][indexPath.row]
    }
    
    func episodesCountAt(section: Int) -> Int {
        return seriesSeasonsBucket[section].count
    }
    
    func getEpisodes() {
        AF.request("https://api.tvmaze.com/shows/\(presenter!.homeEntity.series.id)/episodes")
            .validate()
            .responseDecodable(of: [SeriesDetailEntity].self) { [weak self] (response) in
                switch response.result {
                case .success(let seriesEpisodes):
                    guard let numberOfSeasons = seriesEpisodes.map({ $0.season }).max() else {
                        return
                    }
                    self?.seriesSeasonsBucket = Array(repeating: [], count: numberOfSeasons.advanced(by: 1))
                    seriesEpisodes.forEach { self?.seriesSeasonsBucket[$0.season].append($0) }
                    self?.presenter?.onFetchEpisodesSuccess()
                case .failure:
                    return
                }
            }
    }
}
