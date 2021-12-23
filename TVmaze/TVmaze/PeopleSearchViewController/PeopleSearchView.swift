//
//  PeopleSearchView.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

import UIKit

protocol PresenterToViewPeopleSearchProtocol: UIView {
    var presenter: ViewToPresenterPeopleSearchProtocol? { get set }
    func setupView()
    func displayTableView()
    func displayNoSearchMessage()
    func displayZeroPeopleMessage()
    func showActivityIndicator()
    func hideActivityIndicator()
}

final class PeopleSearchView: UIViewNibLoadable {
    // MARK: Properties
    private weak var zeroResultsSearch: ZeroResultsSearch?
    weak var presenter: ViewToPresenterPeopleSearchProtocol?

    // MARK: IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var headingTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var zeroPeopleFoundViewContainer: UIView! {
        didSet {
            let noResultsSearch = ZeroResultsSearch()
            noResultsSearch.setupLabel(with: "ZeroResultNoSearchMessage".localized(),
                                       image: UIImage(systemName: "message"))
            noResultsSearch.fixInView(zeroPeopleFoundViewContainer)
            zeroResultsSearch = noResultsSearch
        }
    }
    
    // MARK: Class methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: PeopleSearchCellView.identifier, bundle: .none),
                           forCellReuseIdentifier: PeopleSearchCellView.identifier)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func displayTable() {
        hideActivityIndicator()
        tableView.isHidden = false
        zeroPeopleFoundViewContainer.isHidden = true
    }
}

extension PeopleSearchView: PresenterToViewPeopleSearchProtocol {
    func setupView() {
        setupTableView()
    }
    
    func displayTableView() {
        displayTable()
        tableView.reloadData()
    }
    
    func displayNoSearchMessage() {
        zeroPeopleFoundViewContainer.isHidden = false
        zeroResultsSearch?.setupLabel(with: "ZeroResultNoSearchMessage".localized(),
                                      image: UIImage(systemName: "message"))
    }
    
    func displayZeroPeopleMessage() {
        hideActivityIndicator()
        tableView.isHidden = true
        zeroPeopleFoundViewContainer.isHidden = false
        zeroResultsSearch?.setupLabel(with: "ZeroResultMessage".localized(),
                                      image: UIImage(systemName: "exclamationmark.arrow.circlepath"))
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}

// MARK: TableView methods
extension PeopleSearchView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfPeopleInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter, let cell = tableView.dequeueReusableCell(withIdentifier: PeopleSearchCellView.identifier,
                                                                                  for: indexPath) as? PeopleSearchCellView else {
            PeopleSearchCellView.assertCellFailure()
            return UITableViewCell()
        }
        
        let personEntity = presenter.personsAt(indexPath: indexPath)
        cell.setupCell(with: personEntity)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.presentPersonDetail(for: indexPath)
    }
}
