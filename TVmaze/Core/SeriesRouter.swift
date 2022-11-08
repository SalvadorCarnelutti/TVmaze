//
//  SeriesRouter.swift
//  TVmaze
//
//  Created by Salvador on 12/18/21.
//

import UIKit

protocol PresenterToRouterSeriesProtocol: AnyObject {
    var presenter: UIViewController? { get set }
    func presentSeriesDetail(homeEntity: HomeEntity, highlightCellInfo: HighlightCellInfo)
}

final class SeriesRouter: PresenterToRouterSeriesProtocol {
    weak var presenter: UIViewController?
    
    func presentSeriesDetail(homeEntity: HomeEntity, highlightCellInfo: HighlightCellInfo) {
        let viewController = SeriesDetailViewPresenter()
        let interactor = SeriesDetailInteractor(homeEntity: homeEntity, highlightCellInfo: highlightCellInfo)
        let router = SeriesDetailRouter()
        let view = SeriesDetailView()
        
        SeriesDetailConfigurator.injectDependencies(presenter: viewController,
                                                    interactor: interactor,
                                                    router: router,
                                                    view:view)
        presenter?.navigationController?.pushViewController(viewController, animated: true)
    }
}
