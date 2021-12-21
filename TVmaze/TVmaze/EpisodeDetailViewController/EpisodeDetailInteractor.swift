//
//  EpisodeDetailInteractor.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

protocol PresenterToInteractorEpisodeDetailProtocol: AnyObject {
    var seriesDetailEntity: SeriesDetailEntity { get }
    var episodeName: String { get }
}

final class EpisodeDetailInteractor: PresenterToInteractorEpisodeDetailProtocol {
    var seriesDetailEntity: SeriesDetailEntity
    var episodeName: String {
        return seriesDetailEntity.name
    }
    
    init(seriesDetailEntity: SeriesDetailEntity) {
        self.seriesDetailEntity = seriesDetailEntity
    }
}
