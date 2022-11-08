//
//  PINConfigurator.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

final class PINConfigurator {
    static func injectDependencies(presenter: PINViewPresenter,
                                   router: PresenterToRouterProtocol,
                                   view: PresenterToViewPINProtocol) {
        let interactor = PINInteractor()
        presenter.interactor = interactor
        
        router.presenter = presenter
        presenter.router = router
        
        view.presenter = presenter
        presenter.pinView = view
    }
}
