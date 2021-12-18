//
//  HomeRouter.swift
//  TVmaze
//
//  Created by Salvador on 12/18/21.
//

import UIKit

protocol PresenterToRouterHomeProtocol: AnyObject {
    var presenter: UIViewController? { get set }
    func routeToSeriesDetail(homeEntity: HomeEntity)
}

final class HomeRouter: PresenterToRouterHomeProtocol  {
    weak var presenter: UIViewController?
    
    func routeToSeriesDetail(homeEntity: HomeEntity) {
//        presenter?.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: true)
    }
}
