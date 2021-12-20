//
//  SeriesViewController.swift
//  TVmaze
//
//  Created by Salvador on 12/19/21.
//

import UIKit
import Alamofire

final class SeriesDetailViewController: UIViewController {
    private let seriesEpisodesURL = "https://api.tvmaze.com/shows"
    var seriesSeasonsBucket: [[SeriesDetailEntity]] = []
    let seriesView = SeriesDetailView()
    let homeEntity: HomeEntity
    
    override func loadView() {
        super.loadView()
        view = seriesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = homeEntity.series.name
        getEpisodes()
        setupTableView()
    }
    
    init(homeEntity: HomeEntity) {
        self.homeEntity = homeEntity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getEpisodes() {
        AF.request("https://api.tvmaze.com/shows/\(homeEntity.series.id)/episodes")
            .validate()
            .responseDecodable(of: [SeriesDetailEntity].self) { [weak self] (response) in
                switch response.result {
                case .success(let seriesEpisodes):
                    guard let numberOfSeasons = seriesEpisodes.map({ $0.season }).max() else {
                        return
                    }
                    self?.seriesSeasonsBucket = Array(repeating: [], count: numberOfSeasons.advanced(by: 1))
                    seriesEpisodes.forEach { self?.seriesSeasonsBucket[$0.season].append($0) }
                    self?.seriesSeasonsBucket.removeAll(where: { $0.isEmpty })
                    self?.seriesView.tableView.reloadData()
                case .failure:
                    return
                }
            }
    }
    
    private func setupTableView() {
        seriesView.tableView.delegate = self
        seriesView.tableView.dataSource = self
        seriesView.tableView.register(UINib(nibName: SeriesCellView.identifier, bundle: .none),
                           forCellReuseIdentifier: SeriesCellView.identifier)
        seriesView.tableView.register(UINib(nibName: SeriesDetailTableViewHeader.identifier, bundle: .none),
                                      forHeaderFooterViewReuseIdentifier: SeriesDetailTableViewHeader.identifier)
        seriesView.tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension SeriesDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return seriesSeasonsBucket.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0
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
        return seriesSeasonsBucket[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SeriesCellView.identifier, for: indexPath) as? SeriesCellView else {
            SeriesCellView.assertCellFailure()
            return UITableViewCell()
        }
        
        cell.setupCell(with: seriesSeasonsBucket[indexPath.section][indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}
