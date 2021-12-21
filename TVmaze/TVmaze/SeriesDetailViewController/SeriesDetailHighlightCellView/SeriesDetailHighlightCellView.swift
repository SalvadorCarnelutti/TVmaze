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
        let seriesDetailHighlightView = SeriesDetailHighlightView(infoText: homeEntity.seriesInfo.compactMap({ $0 }),
                                                                  imageURL: homeEntity.seriesImageURL,
                                                                  summary: homeEntity.series.summary)
        seriesDetailHighlightView.fixInView(contentView)
    }
}
