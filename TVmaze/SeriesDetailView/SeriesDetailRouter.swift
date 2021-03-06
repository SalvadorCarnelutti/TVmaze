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
        EpisodeDetailConfigurator.injectDependencies(presenter: viewController,
                                                     seriesDetailEntity: seriesDetailEntity)
        presenter?.navigationController?.pushViewController(viewController, animated: true)
    }
}
