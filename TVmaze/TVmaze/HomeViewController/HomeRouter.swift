//
//  HomeRouter.swift
//  TVmaze
//
//  Created by Salvador on 12/18/21.
//

import UIKit

protocol PresenterToRouterHomeProtocol: AnyObject {
    var presenter: UIViewController? { get set }
    func presentSeriesDetail(homeEntity: HomeEntity)
}

final class HomeRouter: PresenterToRouterHomeProtocol  {
    weak var presenter: UIViewController?
    
    func presentSeriesDetail(homeEntity: HomeEntity) {
        let viewController = SeriesDetailViewController(homeEntity: homeEntity)
        presenter?.navigationController?.pushViewController(viewController, animated: true)
    }
}
