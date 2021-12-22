//
//  PinRouter.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

import UIKit

protocol PresenterToRouterProtocol: AnyObject {
    var presenter: UIViewController? { get set }
    func presentHomeView()
}

final class PinRouter: PresenterToRouterProtocol {
    weak var presenter: UIViewController?
    
    func presentHomeView() {
        let viewController = UITabBarViewController()
        viewController.modalPresentationStyle = .fullScreen
        presenter?.present(viewController, animated: false)
    }
}
