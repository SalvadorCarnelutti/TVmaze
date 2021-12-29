//
//  SeriesViewController.swift
//  TVmaze
//
//  Created by Salvador on 12/19/21.
//

import UIKit
import Alamofire

protocol InteractorToPresenterSeriesDetailProtocol: AnyObject {
    var homeEntity: HomeEntity { get }
    func onFetchEpisodesSuccess()
    func onFetchEpisodesFailure()
}

protocol ViewToPresenteSeriesDetailProtocol: UIViewController {
    var homeEntity: HomeEntity { get }
    var highlightCellInfo: HighlightCellInfo { get }
    var numberOfSections: Int { get }
    func seriesDetailAt(indexPath: IndexPath) -> SeriesDetailEntity
    func episodesCountAt(section: Int) -> Int
    func presentEpisodeDetail(for indexPath: IndexPath)
}

final class SeriesDetailViewController: UIViewController {
    var seriesDetailView: PresenterToViewSeriesDetailProtocol!
    var interactor: PresenterToInteractorSeriesDetailProtocol!
    var router: PresenterToRouterSeriesDetailProtocol!
    
    override func loadView() {
        super.loadView()
        view = seriesDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = interactor.seriesName
        interactor.getEpisodes()
        seriesDetailView.setupView()
    }
}

extension SeriesDetailViewController: ViewToPresenteSeriesDetailProtocol {
    var homeEntity: HomeEntity {
        return interactor.homeEntity
    }
    
    var highlightCellInfo: HighlightCellInfo {
        return interactor.highlightCellInfo
    }
    
    var numberOfSections: Int {
        return interactor.numberOfSections
    }
    
    func seriesDetailAt(indexPath: IndexPath) -> SeriesDetailEntity {
        return interactor.seriesDetailAt(indexPath: indexPath)
    }
    
    func episodesCountAt(section: Int) -> Int {
        return interactor.episodesCountAt(section: section)
    }
    
    func presentEpisodeDetail(for indexPath: IndexPath) {
        let seriesDetailEntity = interactor.seriesDetailAt(indexPath: indexPath)
        if seriesDetailEntity.name != "TBA" {
            router.presentEpisodeDetail(seriesDetailEntity: seriesDetailEntity)
        }
    }
}

extension SeriesDetailViewController: InteractorToPresenterSeriesDetailProtocol {
    func onFetchEpisodesSuccess() {
        seriesDetailView.displayTableView()
    }
    
    func onFetchEpisodesFailure() {
        seriesDetailView.displayTableView()
    }
}

