//
//  FavoritesViewController.swift
//  TVmaze
//
//  Created by Salvador on 12/21/21.
//

import UIKit

protocol InteractorToPresenterFavoritesProtocol: AnyObject {
    var favoriteTapClosure: (_ indexPath: IndexPath) -> () { get }
    func onLoadFavorites()
    func onFavoriteRemovalAt(indexPath: IndexPath)
}

protocol ViewToPresenterFavoritesProtocol: UIViewController {
    var numberOfRowsInSection: Int { get }
    func presentSeriesDetail(for indexPath: IndexPath)
    func seriesAt(indexPath: IndexPath) -> HomeEntity
    func toggleFavoriteStatusAt(_ indexPath: IndexPath)
    func highlightCellInfoAt(indexPath: IndexPath) -> HighlightCellInfo
}

final class FavoritesViewController: UIViewController {
    // MARK: Properties
    var favoritesView: PresenterToViewFavoritesProtocol!
    var interactor: PresenterToInteractorFavoritesProtocol!
    var router: PresenterToRouterSeriesProtocol!
    
    // MARK: Lifecycle methods
    override func loadView() {
        super.loadView()
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = interactor.tabTitle
        favoritesView.setupView()
    }
}

// MARK: InteractorToPresenterFavoritesProtocol
extension FavoritesViewController: InteractorToPresenterFavoritesProtocol {
    var favoriteTapClosure: (IndexPath) -> () {
        return toggleFavoriteStatusAt
    }
    
    func onLoadFavorites() {
        interactor.seriesCount == 0 ?
        favoritesView.displayZeroSeriesMessage() : favoritesView.displayTableView()
    }
    
    func onFavoriteRemovalAt(indexPath: IndexPath) {
        favoritesView.removeCellAt(indexPath: indexPath)
        if interactor.seriesCount == 0 {
            favoritesView.displayZeroSeriesMessage()
        }
    }
}

// MARK: ViewToPresenterFavoritesProtocol
extension FavoritesViewController: ViewToPresenterFavoritesProtocol {
    var numberOfRowsInSection: Int {
        return interactor.seriesCount
    }
    
    func seriesAt(indexPath: IndexPath) -> HomeEntity {
        return interactor.seriesInfoAt(indexPath: indexPath)
    }
    
    func presentSeriesDetail(for indexPath: IndexPath) {
        let homeEntity = interactor.seriesInfoAt(indexPath: indexPath)
        router.presentSeriesDetail(homeEntity: homeEntity,
                                   highlightCellInfo: interactor.highlightCellInfoAt(indexPath: indexPath))
    }
    
    func toggleFavoriteStatusAt(_ indexPath: IndexPath) {
        interactor.toggleFavoriteStatusAt(indexPath)
    }
    
    func highlightCellInfoAt(indexPath: IndexPath) -> HighlightCellInfo {
        return interactor.highlightCellInfoAt(indexPath: indexPath)
    }
}
