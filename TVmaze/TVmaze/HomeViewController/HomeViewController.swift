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
    func fetchFilteredSeriesSuccessZeroResults()
    func fetchFilteredSeriesSuccessNonzeroResult()
}

protocol ViewToPresenterHomeProtocol: AnyObject {
    func presentSeriesDetail()
}

final class HomeviewController: UIViewController {
    // MARK: Properties
    private let searchThrottleTime = 0.4
    private lazy var searchController = UISearchController(searchResultsController: nil)
    let homeView = HomeView()
    var interactor: PresenterToInteractorHomeProtocol!
    var router: PresenterToRouterHomeProtocol!
    var searchTask: DispatchWorkItem?
    
    // MARK: Lifecycle methods
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        interactor.getSeries()
        setupSearchController()
    }
    
    // MARK: Class methods
    private func setupTableView() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.tableView.register(UINib(nibName: HomeCellView.identifier, bundle: .none),
                                    forCellReuseIdentifier: HomeCellView.identifier)
        homeView.tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "HomeSearchBar".localized()
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: Tableview methods
extension HomeviewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? interactor.filteredSeriesCount : interactor.seriesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCellView.identifier, for: indexPath) as? HomeCellView else {
            HomeCellView.assertCellFailure()
            return UITableViewCell()
        }
        
        let info = isFiltering ? interactor.filteredSeriesInfoAt(index: indexPath.row) : interactor.seriesInfoAt(index: indexPath.row)
        cell.setupCell(homeEntity: info)
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: InteractorToPresenterHomeProtocol
extension HomeviewController: InteractorToPresenterHomeProtocol {
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

extension HomeviewController: ViewToPresenterHomeProtocol {
    func presentSeriesDetail() {
        // Call router
    }
}

extension HomeviewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        self.searchTask?.cancel()
        
        guard isFiltering else {
            fetchSeriesSuccess()
            return
        }
        
        let task = DispatchWorkItem { [weak self] in
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
