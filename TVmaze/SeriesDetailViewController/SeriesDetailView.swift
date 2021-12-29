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
    // MARK: Properties
    weak var presenter: ViewToPresenteSeriesDetailProtocol? = nil

    // MARK: IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
        
    // MARK: Class methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: SeriesDetailCellView.identifier, bundle: .none),
                           forCellReuseIdentifier: SeriesDetailCellView.identifier)
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
        guard let presenter = presenter else {
            return UITableViewCell()
        }
                
        return getCell(indexPath: indexPath, presenter: presenter)

    }
    
    private func getCell(indexPath: IndexPath, presenter: ViewToPresenteSeriesDetailProtocol) -> UITableViewCell {
        var cell: UITableViewCell
        
        switch indexPath.section {
        case 0:
            guard let detailHighlightCell = tableView.dequeueReusableCell(withIdentifier: SeriesDetailHighlightCellView.identifier,
                                                                          for: indexPath) as? SeriesDetailHighlightCellView else {
                SeriesDetailHighlightCellView.assertCellFailure()
                return UITableViewCell()
            }
            
            detailHighlightCell.setupCell(with: presenter.homeEntity, highlightCellInfo: presenter.highlightCellInfo)
            cell = detailHighlightCell
            
        default:
            guard let seriesDetailCell = tableView.dequeueReusableCell(withIdentifier: SeriesDetailCellView.identifier,
                                                                       for: indexPath) as? SeriesDetailCellView else {
                SeriesDetailCellView.assertCellFailure()
                return UITableViewCell()
            }
            
            seriesDetailCell.setupCell(with: presenter.seriesDetailAt(indexPath: indexPath))
            cell = seriesDetailCell
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section > 0 else {
            return
        }
        
        presenter?.presentEpisodeDetail(for: indexPath)
    }
}
