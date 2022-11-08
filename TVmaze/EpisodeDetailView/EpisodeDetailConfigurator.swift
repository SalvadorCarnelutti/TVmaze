//
//  EpisodeDetailConfigurator.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

final class EpisodeDetailConfigurator {
    static func injectDependencies(presenter: EpisodeDetailViewPresenter,
                                   interactor: EpisodeDetailInteractor,
                                   view: PresenterToViewEpisodeDetailProtocol) {
        presenter.interactor = interactor
        presenter.episodeDetailView = view
    }
}
