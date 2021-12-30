//
//  HomeConfigurator.swift
//  TVmaze
//
//  Created by Salvador on 12/18/21.
//

final class HomeConfigurator {
    static func injectDependencies(presenter: HomeViewPresenter) {
        let interactor = HomeInteractor()
        presenter.interactor = interactor
        interactor.presenter = presenter

        let router = SeriesRouter()
        presenter.router = router
        router.presenter = presenter
        
        let view = HomeView()
        view.presenter = presenter
        presenter.homeView = view
    }
}
