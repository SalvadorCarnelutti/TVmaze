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
    func displayTable()
    func displayZeroSeriesMessage()
    func showActivityIndicator()
    func hideActivityIndicator()
    func showPaginationActivityIndicator()
    func hidePaginationActivityIndicator()
}

final class HomeView: UIViewNibLoadable {
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
    
    @IBOutlet weak var zeroSeriesFoundView: UIView! {
        didSet {
            let zeroResultsSearch = ZeroResultsSearch()
            zeroResultsSearch.fixInView(zeroSeriesFoundView)
            zeroSeriesFoundView.isHidden = false
            tableView.isHidden = true
        }
    }
    
    @IBOutlet weak var paginationActivityIndicator: UIActivityIndicatorView! {
        didSet {
            paginationActivityIndicator.hidesWhenStopped = true
        }
    }
    
    // MARK: Properties
    weak var presenter: ViewToPresenterHomeProtocol?
    
    // MARK: Class methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(UINib(nibName: HomeCellView.identifier, bundle: .none),
                           forCellReuseIdentifier: HomeCellView.identifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= ((presenter?.numberOfRowsInSection ?? 0)  - 1)
    }
}

extension HomeView: PresenterToViewHomeProtocol {
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
    
    func displayTable() {
        hideActivityIndicator()
        hidePaginationActivityIndicator()
        tableView.isHidden = false
        zeroSeriesFoundView.isHidden = true
        tableView.reloadData()
    }
    
    func displayZeroSeriesMessage() {
        hideActivityIndicator()
        tableView.isHidden = true
        zeroSeriesFoundView.isHidden = false
    }
}

// MARK: Tableview methods
extension HomeView: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            presenter?.getSeries()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter, let cell = tableView.dequeueReusableCell(withIdentifier: HomeCellView.identifier, for: indexPath) as? HomeCellView else {
            HomeCellView.assertCellFailure()
            return UITableViewCell()
        }
        
        let info = presenter.seriesAt(indexPath: indexPath)
        cell.setupCell(homeEntity: info)
        cell.selectionStyle = .none
        
        return cell
    }
}
