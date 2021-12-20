//
//  SeriesDetailHighlightCellView.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

import UIKit

final class SeriesDetailHighlightCellView: UITableViewCell {
    // MARK: Class methods
    func setupCell(with homeEntity: HomeEntity) {
        let seriesDetailHighlightView = SeriesDetailHighlightView(homeEntity: homeEntity, highlightStyling: .episodeDetail)
        seriesDetailHighlightView.fixInView(contentView)
    }
}
