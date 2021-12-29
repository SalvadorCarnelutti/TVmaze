//
//  FavoritesRouter.swift
//  TVmaze
//
//  Created by Salvador on 12/21/21.
//

final class FavoritesRouter {
    static func injectDependencies(presenter: FavoritesViewController) {
        let interactor = FavoritesInteractor()
        presenter.interactor = interactor
        interactor.presenter = presenter

        let router = SeriesRouter()
        presenter.router = router
        router.presenter = presenter
        
        let view = FavoritesView()
        view.presenter = presenter
        presenter.favoritesView = view
    }
}
