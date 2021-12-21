//
//  HomeViewController.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import UIKit
import Alamofire

protocol InteractorToPresenterHomeProtocol: AnyObject {
    var favoriteTapClosure: (_ indexPath: IndexPath) -> () { get }
    func onFetchSeriesSuccess()
    func onFetchSeriesSuccess(newIndexPaths: [IndexPath])
    func onFetchSeriesFailure()
    func onFetchFilteredSeriesSuccessZeroResults()
    func onFetchFilteredSeriesSuccessNonzeroResult()
}

protocol ViewToPresenterHomeProtocol: UIViewController {
    var isFiltering: Bool { get }
    var numberOfRowsInSection: Int { get }
    func getSeries()
    func presentSeriesDetail(for indexPath: IndexPath)
    func seriesAt(indexPath: IndexPath) -> HomeEntity
    func toggleFavoriteStatusAt(_ indexPath: IndexPath)
    func highlightCellInfoAt(indexPath: IndexPath) -> HighlightCellInfo
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
        title = "HomeTabBarTitle".localized()
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
    
    private func onEmptySearchBar() {
        homeView.displayTableView()
    }
}

// MARK: InteractorToPresenterHomeProtocol
extension HomeViewController: InteractorToPresenterHomeProtocol {
    var favoriteTapClosure: (IndexPath) -> () {
        return toggleFavoriteStatusAt
    }
    
    func onFetchSeriesFailure() {
        interactor.isFirstPage ? homeView.hideActivityIndicator() : homeView.hidePaginationActivityIndicator()
    }
    
    func onFetchSeriesSuccess(newIndexPaths: [IndexPath]) {
        homeView.displayTableView(with: newIndexPaths)
    }

    func onFetchSeriesSuccess() {
        homeView.displayTableView()
    }
    
    func onFetchFilteredSeriesSuccessZeroResults() {
        homeView.displayZeroSeriesMessage()
    }
    
    func onFetchFilteredSeriesSuccessNonzeroResult() {
        homeView.displayTableView()
    }
}

extension HomeViewController: ViewToPresenterHomeProtocol {
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
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
    
    func presentSeriesDetail(for indexPath: IndexPath) {
        let homeEntity = isFiltering ?
        interactor.filteredSeriesInfoAt(index: indexPath.row) : interactor.seriesInfoAt(index: indexPath.row)
        router.presentSeriesDetail(homeEntity: homeEntity, highlightCellInfo: interactor.highlightCellInfoAt(indexPath: indexPath))
    }
    
    func toggleFavoriteStatusAt(_ indexPath: IndexPath) {
        isFiltering ?
        interactor.toggleFilteredFavoriteStatusAt(indexPath) : interactor.toggleFavoriteStatusAt(indexPath)
        homeView.reloadCellAt(indexPath: IndexPath(row: indexPath.row, section: 0))
    }
    
    func highlightCellInfoAt(indexPath: IndexPath) -> HighlightCellInfo {
        return interactor.highlightCellInfoAt(indexPath: indexPath)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        self.searchTask?.cancel()
        
        guard isFiltering, let searchBarText = searchBar.text else {
            onEmptySearchBar()
            return
        }
        
        let task = DispatchWorkItem { [weak self] in
            self?.homeView.showActivityIndicator()
            self?.interactor.getFilteredSeries(string: searchBarText)
        }
        
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + searchThrottleTime, execute: task)
    }
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true
    }
}
