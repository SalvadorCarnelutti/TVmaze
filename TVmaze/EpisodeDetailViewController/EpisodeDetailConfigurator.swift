//
//  EpisodeDetailConfigurator.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

final class EpisodeDetailConfigurator {
    static func injectDependencies(presenter: EpisodeDetailViewController, seriesDetailEntity: SeriesDetailEntity) {
        let interactor = EpisodeDetailInteractor(seriesDetailEntity: seriesDetailEntity)
        presenter.interactor = interactor
        
        let view = EpisodeDetailView()
        presenter.episodeDetailView = view
    }}
