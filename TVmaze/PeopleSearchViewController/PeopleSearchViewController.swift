//
//  PeopleSearchViewController.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

import UIKit

protocol InteractorToPresenterPeopleSearchProtocol: AnyObject {
    func onFetchPeopleSuccess()
    func onFetchPeopleFailure()
    func onFetchFilteredPeopleSuccessZeroResults()
    func onFetchFilteredPeopleSuccessNonzeroResult()
}

protocol ViewToPresenterPeopleSearchProtocol: UIViewController {
    var numberOfPeopleInSection: Int { get }
    func presentPersonDetail(for indexPath: IndexPath)
    func personsAt(indexPath: IndexPath) -> PersonEntity
}

final class PeopleSearchViewController: UIViewController {
    // MARK: Properties
    private let searchThrottleTime = 0.4
    private lazy var searchController = UISearchController(searchResultsController: nil)
    private var searchTask: DispatchWorkItem?
    var peopleSearchView: PresenterToViewPeopleSearchProtocol!
    var interactor: PresenterToInteractorPeopleSearchProtocol!
    var router: PresenterToRouterPeopleSearchProtocol!
    
    // MARK: Lifecycle methods
    override func loadView() {
        super.loadView()
        view = peopleSearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleSearchView.setupView()
        setupSearchController()
    }
    
    // MARK: Class methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "PeopleSearchBar".localized()
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func onEmptySearchBar() {
        peopleSearchView.displayNoSearchMessage()
    }
}

// MARK: InteractorToPresenterPeopleSearchProtocol
extension PeopleSearchViewController: InteractorToPresenterPeopleSearchProtocol {
    func onFetchPeopleSuccess() {
        peopleSearchView.displayTableView()
    }
    
    func onFetchPeopleFailure() {
        peopleSearchView.hideActivityIndicator()
    }
    
    func onFetchFilteredPeopleSuccessZeroResults() {
        peopleSearchView.displayZeroPeopleMessage()
    }
    
    func onFetchFilteredPeopleSuccessNonzeroResult() {
        peopleSearchView.displayTableView()
    }
}

// MARK: ViewToPresenterPeopleSearchProtocol
extension PeopleSearchViewController: ViewToPresenterPeopleSearchProtocol {
    var numberOfPeopleInSection: Int {
        return interactor.peopleCount
    }
    
    func presentPersonDetail(for indexPath: IndexPath) {
    }
    
    func personsAt(indexPath: IndexPath) -> PersonEntity {
        return interactor.personInfoAt(indexPath: indexPath)
    }
}

extension PeopleSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        self.searchTask?.cancel()
        
        guard searchController.isFiltering, let searchBarText = searchBar.text else {
            onEmptySearchBar()
            return
        }
        
        let task = DispatchWorkItem { [weak self] in
            self?.peopleSearchView.showActivityIndicator()
            self?.interactor.getFilteredPeople(string: searchBarText)
        }
        
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + searchThrottleTime, execute: task)
    }
}
