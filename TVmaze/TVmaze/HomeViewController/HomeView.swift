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
    
    @IBOutlet weak var zeroSeriesFoundView: UIView! {
        didSet {
            let zeroResultsSearch = ZeroResultsSearch()
            zeroResultsSearch.fixInView(zeroSeriesFoundView)
            zeroSeriesFoundView.isHidden = false
            tableView.isHidden = true
        }
    }
    
    // MARK: Properties
    weak var presenter: ViewToPresenterHomeProtocol?
    
    // MARK: Class methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: HomeCellView.identifier, bundle: .none),
                           forCellReuseIdentifier: HomeCellView.identifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension HomeView: PresenterToViewHomeProtocol {
    func setupView() {
        setupTableView()
    }
    
    func displayTable() {
        tableView.isHidden = false
        zeroSeriesFoundView.isHidden = true
        tableView.reloadData()
    }
    
    func displayZeroSeriesMessage() {
        tableView.isHidden = true
        zeroSeriesFoundView.isHidden = false
    }
}

// MARK: Tableview methods
extension HomeView: UITableViewDelegate, UITableViewDataSource {
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
