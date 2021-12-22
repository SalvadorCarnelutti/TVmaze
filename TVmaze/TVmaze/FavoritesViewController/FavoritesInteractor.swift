//
//  FavoritesInteractor.swift
//  TVmaze
//
//  Created by Salvador on 12/21/21.
//

import Foundation

protocol PresenterToInteractorFavoritesProtocol: AnyObject {
    var presenter: InteractorToPresenterFavoritesProtocol? { get set }
    var tabTitle: String { get }
    var seriesCount: Int { get }
    func loadFavorites(favoriteSeries: [HomeEntity])
    func seriesInfoAt(indexPath: IndexPath) -> HomeEntity
    func toggleFavoriteStatusAt(_ indexPath: IndexPath)
    func highlightCellInfoAt(indexPath: IndexPath) -> HighlightCellInfo
}

final class FavoritesInteractor: PresenterToInteractorFavoritesProtocol {
    // MARK: Properties
    private var series: [HomeEntity] = []
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
        return series[indexPath.row]
    }
    
    func toggleFavoriteStatusAt(_ indexPath: IndexPath) {
        series[indexPath.row].toggleFavoriteStatus()
        if !series[indexPath.row].isFavorited {
            series.remove(at: indexPath.row)
            presenter?.onFavoriteRemovalAt(indexPath: indexPath)
        }
    }
    
    func highlightCellInfoAt(indexPath: IndexPath) -> HighlightCellInfo {
        return HighlightCellInfo(indexPath: indexPath,
                                 cellClosure: presenter!.favoriteTapClosure,
                                 insideCell: true)
    }
}
