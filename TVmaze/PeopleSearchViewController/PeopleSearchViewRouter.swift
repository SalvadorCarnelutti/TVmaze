//
//  PeopleSearchViewRouter.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

import UIKit

protocol PresenterToRouterPeopleSearchProtocol: AnyObject {
    var presenter: UIViewController? { get set }
}

final class PeopleSearchViewRouter: PresenterToRouterPeopleSearchProtocol {
    weak var presenter: UIViewController?
}
