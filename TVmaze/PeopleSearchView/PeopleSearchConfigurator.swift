//
//  PeopleSearchConfigurator.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

final class PeopleSearchConfigurator {
    static func injectDependencies(presenter: PeopleSearchViewPresenter) {
        let interactor = PeopleSearchInteractor()
        presenter.interactor = interactor
        interactor.presenter = presenter

        let router = PeopleSearchViewRouter()
        presenter.router = router
        router.presenter = presenter
        
        let view = PeopleSearchView()
        view.presenter = presenter
        presenter.peopleSearchView = view
    }
}
