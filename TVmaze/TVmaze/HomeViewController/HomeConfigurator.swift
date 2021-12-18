//
//  HomeConfigurator.swift
//  TVmaze
//
//  Created by Salvador on 12/18/21.
//

import Foundation

final class HomeConfigurator {
    static func injectDependencies(presenter: HomeviewController) {
        let interactor = HomeInteractor()
        presenter.interactor = interactor
        interactor.presenter = presenter

        let router = HomeRouter()
        presenter.router = router
        router.presenter = presenter
    }
}
