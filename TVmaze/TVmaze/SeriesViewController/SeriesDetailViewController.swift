//
//  SeriesViewController.swift
//  TVmaze
//
//  Created by Salvador on 12/19/21.
//

import UIKit

final class SeriesDetailViewController: UIViewController {
    let seriesView = SeriesDetailView()
    let homeEntity: HomeEntity
    
    override func loadView() {
        super.loadView()
        view = seriesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let seriesDetailHighlightView = SeriesDetailHighlightView(homeEntity: homeEntity, highlightStyling: .episodeDetail)
        seriesDetailHighlightView.fixInView(seriesView.testView)
        title = homeEntity.series.name
    }
    
    init(homeEntity: HomeEntity) {
        self.homeEntity = homeEntity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
