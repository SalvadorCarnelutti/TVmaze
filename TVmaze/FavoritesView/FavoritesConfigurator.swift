//
//  FavoritesConfigurator.swift
//  TVmaze
//
//  Created by Salvador on 12/21/21.
//

final class FavoritesConfigurator {
    static func injectDependencies(presenter: FavoritesViewPresenter,
                                   router: PresenterToRouterSeriesProtocol,
                                   view: PresenterToViewFavoritesProtocol) {
        let interactor = FavoritesInteractor()
        presenter.interactor = interactor
        interactor.presenter = presenter

        presenter.router = router
        router.presenter = presenter
        
        view.presenter = presenter
        presenter.favoritesView = view
    }
}
