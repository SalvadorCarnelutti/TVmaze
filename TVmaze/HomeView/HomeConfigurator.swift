//
//  HomeConfigurator.swift
//  TVmaze
//
//  Created by Salvador on 12/18/21.
//

final class HomeConfigurator {
    static func injectDependencies(presenter: HomeViewPresenter,
                                   interactor: PresenterToInteractorHomeProtocol,
                                   router: PresenterToRouterSeriesProtocol,
                                   view: PresenterToViewHomeProtocol) {
        presenter.interactor = interactor
        interactor.presenter = presenter

        presenter.router = router
        router.presenter = presenter
        
        view.presenter = presenter
        presenter.homeView = view
    }
}
