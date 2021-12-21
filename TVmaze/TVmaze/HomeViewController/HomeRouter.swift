//
//  HomeRouter.swift
//  TVmaze
//
//  Created by Salvador on 12/18/21.
//

import UIKit

protocol PresenterToRouterHomeProtocol: AnyObject {
    var presenter: UIViewController? { get set }
    func presentSeriesDetail(homeEntity: HomeEntity, highlightCellInfo: HighlightCellInfo)
}

final class HomeRouter: PresenterToRouterHomeProtocol  {
    weak var presenter: UIViewController?
    
    func presentSeriesDetail(homeEntity: HomeEntity, highlightCellInfo: HighlightCellInfo) {
        let viewController = SeriesDetailViewController()
        SeriesDetailConfigurator.injectDependencies(presenter: viewController, homeEntity: homeEntity, highlightCellInfo: highlightCellInfo)
        presenter?.navigationController?.pushViewController(viewController, animated: true)
    }
}
