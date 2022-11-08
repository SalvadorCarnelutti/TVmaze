//
//  SeriesDetailConfigurator.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

final class SeriesDetailConfigurator {
    static func injectDependencies(presenter: SeriesDetailViewPresenter,
                                   interactor: PresenterToInteractorSeriesDetailProtocol,
                                   router: PresenterToRouterSeriesDetailProtocol,
                                   view: SeriesDetailView) {
        presenter.interactor = interactor
        interactor.presenter = presenter

        presenter.router = router
        router.presenter = presenter
        
        view.presenter = presenter
        presenter.seriesDetailView = view
    }
}
