//
//  HomeView.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import UIKit

protocol PresenterToViewHomeProtocol: UIView {
    var presenter: ViewToPresenterHomeProtocol? { get set }
    func setupView()
    func displayTableView()
    func reloadCellAt(indexPath: IndexPath)
    func displayTableView(with newIndexPaths: [IndexPath])
    func displayZeroSeriesMessage()
    func showActivityIndicator()
    func hideActivityIndicator()
    func showPaginationActivityIndicator()
    func hidePaginationActivityIndicator()
}

final class HomeView: UIViewNibLoadable {
    // MARK: Properties
    weak var presenter: ViewToPresenterHomeProtocol?

    // MARK: IBOutlets
    @IBOutlet weak var homeTitle: UILabel! {
        didSet {
            homeTitle.text = "HomeTitle".localized()
            homeTitle.font = UIFont.boldSystemFont(ofSize: 36.0)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var zeroSeriesFoundViewContainer: UIView! {
        didSet {
            let zeroResultsSearch = ZeroResultsSearch()
            zeroResultsSearch.setupView(with: "ZeroResultMessage".localized())
            zeroResultsSearch.fixInView(zeroSeriesFoundViewContainer)
            zeroSeriesFoundViewContainer.isHidden = true
        }
    }
    
    @IBOutlet weak var paginationActivityIndicator: UIActivityIndicatorView! {
        didSet {
            paginationActivityIndicator.hidesWhenStopped = true
        }
    }

    // MARK: Class methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(UINib(nibName: HomeCellView.identifier, bundle: .none),
                           forCellReuseIdentifier: HomeCellView.identifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    private func displayTable() {
        hideAllActivityIndicators()
        tableView.isHidden = false
        zeroSeriesFoundViewContainer.isHidden = true
    }
    
    private func hideAllActivityIndicators() {
        hideActivityIndicator()
        hidePaginationActivityIndicator()
    }
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        let lastCurrentIndex = (presenter?.numberOfSeriesInSection ?? 0) - 1
        return indexPath.row >= lastCurrentIndex
    }
}

extension HomeView: PresenterToViewHomeProtocol {
    func reloadCellAt(indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func showPaginationActivityIndicator() {
        paginationActivityIndicator.startAnimating()
    }
    
    func hidePaginationActivityIndicator() {
        paginationActivityIndicator.stopAnimating()
    }
    
    func setupView() {
        setupTableView()
        presenter?.getSeries()
    }
    
    func displayTableView() {
        displayTable()
        tableView.reloadData()
    }
    
    func displayTableView(with newIndexPaths: [IndexPath]) {
        displayTable()
        tableView.insertRows(at: newIndexPaths, with: .automatic)
    }
    
    func displayZeroSeriesMessage() {
        hideAllActivityIndicators()
        tableView.isHidden = true
        zeroSeriesFoundViewContainer.isHidden = false
    }
}

// MARK: TableView methods
extension HomeView: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let presenter = presenter,
        !presenter.isFiltering,
        indexPaths.contains(where: isLoadingCell) else {
            return
        }
        
        presenter.getSeries()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfSeriesInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter, let cell = tableView.dequeueReusableCell(withIdentifier: HomeCellView.identifier,
                                                                                  for: indexPath) as? HomeCellView else {
            HomeCellView.assertCellFailure()
            return UITableViewCell()
        }
        
        let homeEntity = presenter.seriesAt(indexPath: indexPath)
        let highlightCellInfo = presenter.highlightCellInfoAt(indexPath: indexPath)
        cell.setupCell(with: homeEntity, highlightCellInfo: highlightCellInfo)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.presentSeriesDetail(for: indexPath)
    }
}
