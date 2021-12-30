//
//  EpisodeDetailViewPresenter.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

import UIKit

protocol ViewToPresenterEpisodeDetailProtocol: AnyObject {
    func setupView(with seriesDetailEntity: SeriesDetailEntity)
}

final class EpisodeDetailViewPresenter: UIViewController {
    // MARK: Properties
    var episodeDetailView: PresenterToViewEpisodeDetailProtocol!
    var interactor: PresenterToInteractorEpisodeDetailProtocol!
    
    // MARK: Lifecycle methods
    override func loadView() {
        super.loadView()
        view = episodeDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = interactor.episodeName
        episodeDetailView.setupView(with: interactor.seriesDetailEntity)
    }
}
