//
//  HomeInteractor.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import Alamofire

protocol PresenterToInteractorHomeProtocol: AnyObject {
    var presenter: InteractorToPresenterHomeProtocol? { get set }
    var seriesCount: Int { get }
    var isFirstPage: Bool { get }
    var getFavorites: [HomeEntity] { get }
    func getSeries()
    func getFilteredSeries(string: String)
    func seriesInfoAt(indexPath: IndexPath) -> HomeEntity
    func toggleFavoriteStatusAt(_ indexPath: IndexPath)
    func highlightCellInfoAt(indexPath: IndexPath) -> HighlightCellInfo
    func resetSeriesFavoriteStatus()
}

final class HomeInteractor: PresenterToInteractorHomeProtocol {
    // MARK: Properties
    private let seriesURL = "https://api.tvmaze.com/shows"
    private let seriesSearchURL = "https://api.tvmaze.com/search/shows"
    private var currentPage = 0
    private var isFetchInProgress = false
    private var hasLoadedAllSeries = false
    private var series: [HomeEntity] = []
    private var filteredSeries: [HomeEntity] = []
    weak var presenter: InteractorToPresenterHomeProtocol?
    
    var tabTitle: String {
        return "HomeTabBarTitle".localized()
    }
    
    var isFirstPage: Bool {
        return currentPage == 0
    }

    var seriesCount: Int {
        return (presenter?.isFiltering ?? false) ? filteredSeries.count : series.count
    }
    
    var getFavorites: [HomeEntity] {
        return (presenter?.isFiltering ?? false) ?
        filteredSeries.filter { $0.isFavorited } : series.filter { $0.isFavorited }
    }
    
    // MARK: Class methods
    func seriesInfoAt(indexPath: IndexPath) -> HomeEntity {
        return (presenter?.isFiltering ?? false) ?
        filteredSeries[indexPath.row] : series[indexPath.row]
    }
    
    func toggleFavoriteStatusAt(_ indexPath: IndexPath) {
        (presenter?.isFiltering ?? false) ?
        filteredSeries[indexPath.row].toggleFavoriteStatus() : series[indexPath.row].toggleFavoriteStatus()
    }
    
    func highlightCellInfoAt(indexPath: IndexPath) -> HighlightCellInfo {
        return HighlightCellInfo(indexPath: indexPath,
                                 cellClosure: presenter!.favoriteTapClosure,
                                 insideCell: true)
    }
    
    func resetSeriesFavoriteStatus() {
        series.indices.forEach { series[$0].resetFavoriteStatus() }
        presenter?.onFavoritesStatusReset()
    }
    
    func getSeries() {
        guard !isFetchInProgress, !hasLoadedAllSeries else { return }
        
        isFetchInProgress = true
        let parameters: Parameters = ["page": currentPage]
        
        AF.request(seriesURL,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.queryString)
            .validate()
            .responseDecodable(of: [Series].self) { [weak self] (response) in
                self?.isFetchInProgress = false
                
                switch response.result {
                case .success(let series):
                    let newIndexPaths = self?.calculateIndexPathsToReload(from: series) ?? []
                    self?.series.append(contentsOf: series.map { HomeEntity(series: $0) })
                    self?.currentPage += 1
                    self?.presenter?.onFetchSeriesSuccess(newIndexPaths: newIndexPaths)
                case .failure:
                    self?.presenter?.onFetchSeriesFailure()
                    if case 404 = response.response?.statusCode{
                        self?.hasLoadedAllSeries = true
                    }
                }
            }
    }
    
    func getFilteredSeries(string: String) {
        resetSeriesFavoriteStatus()
        
        let parameters: Parameters = ["q": string]
        AF.request(seriesSearchURL,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.queryString)
            .validate()
            .responseDecodable(of: [FilteredSeries].self) { [weak self] (response) in
                switch response.result {
                case .success(let filteredSeries) where filteredSeries.isEmpty:
                    self?.filteredSeries = []
                    self?.presenter?.onFetchFilteredSeriesSuccessZeroResults()
                case .success(let filteredSeries):
                    self?.filteredSeries = filteredSeries.map { HomeEntity(series: $0.series) }
                    self?.presenter?.onFetchFilteredSeriesSuccessNonzeroResult()
                case .failure:
                    self?.presenter?.onFetchSeriesFailure()
                }
            }
    }
    
    private func calculateIndexPathsToReload(from newSeries: [Series]) -> [IndexPath] {
        let startIndex = seriesCount
        let endIndex = startIndex + newSeries.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
