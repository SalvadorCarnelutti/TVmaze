//
//  EpisodeDetailView.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

import UIKit

protocol PresenterToViewEpisodeDetailProtocol: UIView {
    func setupView(with seriesDetailEntity: SeriesDetailEntity)
}

final class EpisodeDetailView: UIViewNibLoadable {
    // MARK: IBOutlets
    @IBOutlet weak var detailHighlightContainer: UIView!
}

extension EpisodeDetailView: PresenterToViewEpisodeDetailProtocol {
    func setupView(with seriesDetailEntity: SeriesDetailEntity) {
        let detailHighlightView = EpisodeDetailHighlightView(detailHighlightInfo: seriesDetailEntity.episodeDetailHighlightInfo)
        detailHighlightView.fixInView(detailHighlightContainer)
    }
}
