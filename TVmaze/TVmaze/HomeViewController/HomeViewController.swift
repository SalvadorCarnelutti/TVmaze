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
}

protocol ViewToPresenterHomeProtocol: AnyObject {
    func presentSeriesDetail()
}

final class HomeviewController: UIViewController {
    // MARK: Properties
    let homeView = HomeView()
    var interactor: PresenterToInteractorHomeProtocol!
    var router: PresenterToRouterHomeProtocol!
    
    // MARK: Lifecycle methods
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        interactor.getSeries()
    }
    
    // MARK: Class methods
    func setupTableView() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.tableView.register(UINib(nibName: HomeCellView.identifier, bundle: .none),
                                    forCellReuseIdentifier: HomeCellView.identifier)
        homeView.tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

// MARK: Tableview methods
extension HomeviewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.seriesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCellView.identifier, for: indexPath) as? HomeCellView else {
            HomeCellView.assertCellFailure()
            return UITableViewCell()
        }
        
        cell.setupCell(homeEntity: interactor.infoAt(index: indexPath.row))
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: InteractorToPresenterHomeProtocol
extension HomeviewController: InteractorToPresenterHomeProtocol {
    func fetchSeriesSuccess() {
        homeView.tableView.reloadData()
    }
}

extension HomeviewController: ViewToPresenterHomeProtocol {
    func presentSeriesDetail() {
        // Call router
    }
}
