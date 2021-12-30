//
//  SeriesDetailConfigurator.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

final class SeriesDetailConfigurator {
    static func injectDependencies(presenter: SeriesDetailViewPresenter, homeEntity: HomeEntity, highlightCellInfo: HighlightCellInfo) {
        let interactor = SeriesDetailInteractor(homeEntity: homeEntity, highlightCellInfo: highlightCellInfo)
        presenter.interactor = interactor
        interactor.presenter = presenter

        let router = SeriesDetailRouter()
        presenter.router = router
        router.presenter = presenter
        
        let view = SeriesDetailView()
        view.presenter = presenter
        presenter.seriesDetailView = view
    }
}
