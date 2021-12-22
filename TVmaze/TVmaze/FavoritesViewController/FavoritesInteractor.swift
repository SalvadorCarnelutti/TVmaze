//
//  FavoritesInteractor.swift
//  TVmaze
//
//  Created by Salvador on 12/21/21.
//

import Foundation

protocol PresenterToInteractorFavoritesProtocol: AnyObject {
    var presenter: InteractorToPresenterFavoritesProtocol? { get set }
    var isAlphabeticallySorted: Bool { get }
    var tabTitle: String { get }
    var seriesCount: Int { get }
    func loadFavorites(favoriteSeries: [HomeEntity])
    func seriesInfoAt(indexPath: IndexPath) -> HomeEntity
    func toggleFavoriteStatusAt(_ indexPath: IndexPath)
    func highlightCellInfoAt(indexPath: IndexPath) -> HighlightCellInfo
    func toggleAlphabeticalSort()
}

final class FavoritesInteractor: PresenterToInteractorFavoritesProtocol {
    // MARK: Properties
    private(set) var isAlphabeticallySorted: Bool = false
    private var series: [HomeEntity] = [] {
        didSet {
            alphabeticallySortedSeries = series.sorted(by: { $0.series.name < $1.series.name })
        }
    }
    
    private var alphabeticallySortedSeries: [HomeEntity] = []
    weak var presenter: InteractorToPresenterFavoritesProtocol?

    var tabTitle: String {
        return "FavoritesTabBarTitle".localized()
    }
    
    var seriesCount: Int {
        return series.count
    }
    
    // MARK: Class methods
    func loadFavorites(favoriteSeries: [HomeEntity]) {
        series = favoriteSeries
        presenter?.onLoadFavorites()
    }
    
    func seriesInfoAt(indexPath: IndexPath) -> HomeEntity {
        return isAlphabeticallySorted ?
        alphabeticallySortedSeries[indexPath.row] : series[indexPath.row]
    }
    
    func toggleFavoriteStatusAt(_ indexPath: IndexPath) {
        if isAlphabeticallySorted {
            series.removeAll(where: { $0.series.id == alphabeticallySortedSeries[indexPath.row].series.id })
            presenter?.onFavoriteRemovalAt(indexPath: indexPath)
        } else {
            series.remove(at: indexPath.row)
            presenter?.onFavoriteRemovalAt(indexPath: indexPath)
        }
    }
    
    func highlightCellInfoAt(indexPath: IndexPath) -> HighlightCellInfo {
        return HighlightCellInfo(indexPath: indexPath,
                                 cellClosure: presenter!.favoriteTapClosure,
                                 insideCell: true)
    }
    
    func toggleAlphabeticalSort() {
        isAlphabeticallySorted.toggle()
    }
}
