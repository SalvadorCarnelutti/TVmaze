//
//  HomeViewController.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import UIKit
import Alamofire

protocol InteractorToPresenterHomeProtocol: AnyObject {
    func fetchSeriesSuccess()
    func fetchSeriesFailure()
    func fetchFilteredSeriesSuccessZeroResults()
    func fetchFilteredSeriesSuccessNonzeroResult()
}

protocol ViewToPresenterHomeProtocol: AnyObject {
    var numberOfRowsInSection: Int { get }
    func getSeries()
    func presentSeriesDetail()
    func seriesAt(indexPath: IndexPath) -> HomeEntity
}

final class HomeViewController: UIViewController {
    // MARK: Properties
    private let searchThrottleTime = 0.4
    private lazy var searchController = UISearchController(searchResultsController: nil)
    private var searchTask: DispatchWorkItem?
    var homeView: PresenterToViewHomeProtocol!
    var interactor: PresenterToInteractorHomeProtocol!
    var router: PresenterToRouterHomeProtocol!
    
    // MARK: Lifecycle methods
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.setupView()
        setupSearchController()
    }
    
    // MARK: Class methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "HomeSearchBar".localized()
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: InteractorToPresenterHomeProtocol
extension HomeViewController: InteractorToPresenterHomeProtocol {
    func fetchSeriesFailure() {
        interactor.isFirstPage ? homeView.hideActivityIndicator() : homeView.hidePaginationActivityIndicator()
    }
    
    func fetchSeriesSuccess() {
        homeView.displayTable()
    }
    
    func fetchFilteredSeriesSuccessZeroResults() {
        homeView.displayZeroSeriesMessage()
    }
    
    func fetchFilteredSeriesSuccessNonzeroResult() {
        homeView.displayTable()
    }
}

extension HomeViewController: ViewToPresenterHomeProtocol {
    var numberOfRowsInSection: Int {
        return isFiltering ? interactor.filteredSeriesCount : interactor.seriesCount
    }
    
    func getSeries() {
        interactor.isFirstPage ? homeView.showActivityIndicator() : homeView.showPaginationActivityIndicator()
        interactor.getSeries()
    }
    
    func seriesAt(indexPath: IndexPath) -> HomeEntity {
        return isFiltering ?
        interactor.filteredSeriesInfoAt(index: indexPath.row) : interactor.seriesInfoAt(index: indexPath.row)
    }
    
    func presentSeriesDetail() {
        // Call router
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        self.searchTask?.cancel()
        
        guard isFiltering else {
            fetchSeriesSuccess()
            return
        }
        
        let task = DispatchWorkItem { [weak self] in
            self?.homeView.showActivityIndicator()
            self?.interactor.getFilteredSeries(string: searchBar.text!)
        }
        
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + searchThrottleTime, execute: task)
    }
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
}
