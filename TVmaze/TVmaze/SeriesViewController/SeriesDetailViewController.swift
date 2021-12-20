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
        let seriesDetailHighlightView = SeriesDetailHighlightView(homeEntity: homeEntity, highlightStyling: .episodeDetail)
        seriesDetailHighlightView.fixInView(seriesView.seriesDetailHighlightContainer)
        title = homeEntity.series.name
        getEpisodes()
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
                case .failure:
                    return
                }
            }
    }
}
