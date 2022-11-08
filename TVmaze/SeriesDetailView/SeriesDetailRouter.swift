//
//  SeriesDetailRouter.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

import UIKit

protocol PresenterToRouterSeriesDetailProtocol: AnyObject {
    var presenter: UIViewController? { get set }
    func presentEpisodeDetail(seriesDetailEntity: SeriesDetailEntity)
}

final class SeriesDetailRouter: PresenterToRouterSeriesDetailProtocol  {
    weak var presenter: UIViewController?
    
    func presentEpisodeDetail(seriesDetailEntity: SeriesDetailEntity) {
        let viewController = EpisodeDetailViewPresenter()
        let interactor = EpisodeDetailInteractor(seriesDetailEntity: seriesDetailEntity)
        let view = EpisodeDetailView()
        
        EpisodeDetailConfigurator.injectDependencies(presenter: viewController,
                                                     interactor: interactor,
                                                     view: view)
        presenter?.navigationController?.pushViewController(viewController, animated: true)
    }
}
