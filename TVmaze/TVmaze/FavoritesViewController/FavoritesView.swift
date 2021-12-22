//
//  FavoritesView.swift
//  TVmaze
//
//  Created by Salvador on 12/21/21.
//


import UIKit

protocol PresenterToViewFavoritesProtocol: UIView {
    var presenter: ViewToPresenterFavoritesProtocol? { get set }
    func setupView()
    func displayTableView()
    func removeCellAt(indexPath: IndexPath)
    func displayZeroSeriesMessage()
    func showActivityIndicator()
    func hideActivityIndicator()
}

final class FavoritesView: UIViewNibLoadable {
    // MARK: IBOutlets
    @IBOutlet weak var homeTitle: UILabel! {
        didSet {
            homeTitle.text = "HomeTitle".localized()
            homeTitle.font = UIFont.boldSystemFont(ofSize: 36.0)
        }
    }
    
    @IBOutlet weak var alphabeticalSortContainer: UIView!
    
    @IBOutlet weak var aSquareImage: UIImageView! {
        didSet {
            aSquareImage.isUserInteractionEnabled = false
        }
    }
    
    @IBOutlet weak var zSquareImage: UIImageView! {
        didSet {
            zSquareImage.isUserInteractionEnabled = false
        }
    }
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var zeroFavoritesFoundView: UIView! {
        didSet {
            let zeroResultsSearch = ZeroResultsSearch()
            zeroResultsSearch.setupView(with: "ZeroFavoritesMessage".localized())
            zeroResultsSearch.fixInView(zeroFavoritesFoundView)
            zeroFavoritesFoundView.isHidden = false
            tableView.isHidden = true
        }
    }
    
    // MARK: Properties
    weak var presenter: ViewToPresenterFavoritesProtocol?
    
    // MARK: Class methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: HomeCellView.identifier, bundle: .none),
                           forCellReuseIdentifier: HomeCellView.identifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension FavoritesView: PresenterToViewFavoritesProtocol {
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func setupView() {
        setupTableView()
        let favoriteTap = UITapGestureRecognizer(target: self, action: #selector(self.handleSortTap))
        alphabeticalSortContainer.addGestureRecognizer(favoriteTap)
    }
    
    func displayTableView() {
        displayTable()
        tableView.reloadData()
    }
    
    func removeCellAt(indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
    }
    
    func displayTableView(with newIndexPaths: [IndexPath]) {
        displayTable()
        tableView.insertRows(at: newIndexPaths, with: .automatic)
    }
    
    func displayZeroSeriesMessage() {
        hideAllActivityIndicators()
        tableView.isHidden = true
        zeroFavoritesFoundView.isHidden = false
    }
    
    private func displayTable() {
        hideAllActivityIndicators()
        tableView.isHidden = false
        zeroFavoritesFoundView.isHidden = true
    }
    
    private func hideAllActivityIndicators() {
        hideActivityIndicator()
    }
    
    @objc private func handleSortTap() {
        guard let presenter = presenter else {
            return
        }
        
        presenter.toggleAlphabeticalSort()
        let aImageName = presenter.isAlphabeticallySorted ? "a.square.fill" : "a.square"
        let zImageName = presenter.isAlphabeticallySorted ? "z.square.fill" : "z.square"
        aSquareImage.image = UIImage(systemName: aImageName)
        zSquareImage.image = UIImage(systemName: zImageName)
    }
}

// MARK: TableView methods
extension FavoritesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection ?? 0
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
