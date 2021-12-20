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

protocol ViewToPresenteSeriesDetailProtocol: AnyObject {
    var homeEntity: HomeEntity { get }
    var numberOfSections: Int { get }
    func seriesDetailAt(indexPath: IndexPath) -> SeriesDetailEntity
    func episodesCountAt(section: Int) -> Int
}

final class SeriesDetailViewController: UIViewController {
    var seriesDetailView: PresenterToViewSeriesDetailProtocol!
    var interactor: PresenterToInteractorSeriesDetailProtocol!
    var router: PresenterToRouterHomeProtocol!

    
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
    
    func seriesDetailAt(indexPath: IndexPath) -> SeriesDetailEntity {
        return interactor.seriesDetailAt(indexPath: indexPath)    }
    
    func episodesCountAt(section: Int) -> Int {
        return interactor.episodesCountAt(section: section)
    }
    
    var numberOfSections: Int {
        return interactor.numberOfSections
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

