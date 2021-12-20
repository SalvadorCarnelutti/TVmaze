//
//  SeriesDetailView.swift
//  TVmaze
//
//  Created by Salvador on 12/19/21.
//

import UIKit

protocol PresenterToViewSeriesDetailProtocol: UIView {
    var presenter: ViewToPresenteSeriesDetailProtocol? { get set }
    func setupView()
    func displayTableView()
    func showActivityIndicator()
}

final class SeriesDetailView: UIViewNibLoadable {
    // MARK: IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    weak var presenter: ViewToPresenteSeriesDetailProtocol? = nil
    
    // MARK: Class methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: SeriesCellView.identifier, bundle: .none),
                           forCellReuseIdentifier: SeriesCellView.identifier)
        tableView.register(UINib(nibName: SeriesDetailHighlightCellView.identifier, bundle: .none),
                           forCellReuseIdentifier: SeriesDetailHighlightCellView.identifier)
        tableView.register(UINib(nibName: SeriesDetailTableViewHeader.identifier, bundle: .none),
                           forHeaderFooterViewReuseIdentifier: SeriesDetailTableViewHeader.identifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension SeriesDetailView: PresenterToViewSeriesDetailProtocol {
    func setupView() {
        setupTableView()
    }
    
    func displayTableView() {
        hideActivityIndicator()
        tableView.reloadData()
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}

extension SeriesDetailView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? .leastNormalMagnitude : 80.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SeriesDetailTableViewHeader.identifier) as? SeriesDetailTableViewHeader else {
            SeriesDetailTableViewHeader.assertHeaderFailure()
            return UIView()
        }
        
        headerView.setupHeader(with: section)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section > 0, let presenter = presenter else {
            return 1
        }
        
        return presenter.episodesCountAt(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let presenter = presenter, let cell = tableView.dequeueReusableCell(withIdentifier: SeriesDetailHighlightCellView.identifier, for: indexPath) as? SeriesDetailHighlightCellView else {
                SeriesDetailHighlightCellView.assertCellFailure()
                return UITableViewCell()
            }
            
            cell.setupCell(with: presenter.homeEntity)
            cell.selectionStyle = .none
            
            return cell
        } else {
            guard let presenter = presenter, let cell = tableView.dequeueReusableCell(withIdentifier: SeriesCellView.identifier, for: indexPath) as? SeriesCellView else {
                SeriesCellView.assertCellFailure()
                return UITableViewCell()
            }
            
            cell.setupCell(with: presenter.seriesDetailAt(indexPath: indexPath))
            cell.selectionStyle = .none
            
            return cell
        }
    }
}
