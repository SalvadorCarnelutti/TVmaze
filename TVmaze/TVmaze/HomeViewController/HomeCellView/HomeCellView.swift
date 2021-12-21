//
//  HomeCellView.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import UIKit

final class HomeCellView: UITableViewCell {
    // MARK: IBOutlets
    @IBOutlet weak var seriesHighlightViewContainer: UIView!
    
    // MARK: Class methods
    func setupCell(with homeEntity: HomeEntity, highlightCellInfo: HighlightCellInfo) {
        let highlightView = SeriesHighlightView(highlightInfo: homeEntity.homeHighlightInfo, highlightCellInfo: highlightCellInfo)
        highlightView.fixInView(seriesHighlightViewContainer)
    }
}
