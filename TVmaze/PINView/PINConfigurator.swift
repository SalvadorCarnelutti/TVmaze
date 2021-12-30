//
//  PINConfigurator.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

final class PINConfigurator {
    static func injectDependencies(presenter: PINViewPresenter) {
        let interactor = PINInteractor()
        presenter.interactor = interactor
        
        let router = PinRouter()
        router.presenter = presenter
        presenter.router = router
        
        let pinView = PINView()
        pinView.presenter = presenter
        presenter.pinView = pinView
    }
}
