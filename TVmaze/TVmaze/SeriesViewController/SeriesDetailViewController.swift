//
//  SeriesViewController.swift
//  TVmaze
//
//  Created by Salvador on 12/19/21.
//

import UIKit
import Alamofire

protocol InteractorToPresenterSeriesDetailProtocol: AnyObject {
    func onFetchEpisodesSuccess()
    func onFetchEpisodesFailure()
    
    var homeEntity: HomeEntity { get }
}

protocol ViewToPresenteSeriesDetailProtocol: AnyObject {
    var homeEntity: HomeEntity { get }
    var numberOfSections: Int { get }
    func seriesDetailAt(indexPath: IndexPath) -> SeriesDetailEntity
    func episodesCountAt(section: Int) -> Int
}

final class SeriesDetailViewController: UIViewController {
    var seriesView: PresenterToViewSeriesDetailProtocol!
    var interactor: PresenterToInteractorSeriesDetailProtocol!
    var homeEntity: HomeEntity
    
    override func loadView() {
        super.loadView()
        seriesView = SeriesDetailView()
        seriesView.presenter = self
        view = seriesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = homeEntity.series.name
        seriesView.showActivityIndicator()
        interactor = SeriesDetailInteractor()
        interactor.presenter = self
        interactor.getEpisodes()
        seriesView.setupView()
    }
    
    init(homeEntity: HomeEntity) {
        self.homeEntity = homeEntity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SeriesDetailViewController: ViewToPresenteSeriesDetailProtocol {
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
        seriesView.displayTableView()
    }
    
    func onFetchEpisodesFailure() {
        seriesView.displayTableView()
    }
}

