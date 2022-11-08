//
//  PeopleSearchConfigurator.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

final class PeopleSearchConfigurator {
    static func injectDependencies(presenter: PeopleSearchViewPresenter,
                                   interactor: PresenterToInteractorPeopleSearchProtocol,
                                   router: PresenterToRouterPeopleSearchProtocol,
                                   view: PresenterToViewPeopleSearchProtocol) {
        presenter.interactor = interactor
        interactor.presenter = presenter

        presenter.router = router
        router.presenter = presenter
        
        view.presenter = presenter
        presenter.peopleSearchView = view
    }
}
