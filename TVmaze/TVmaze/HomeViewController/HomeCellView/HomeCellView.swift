//
//  HomeCellView.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import UIKit

final class HomeCellView: UITableViewCell {
    // MARK: IBOutlets
    @IBOutlet weak var seriesHighlightView: UIView!
    
    // MARK: Class methods
    func setupCell(homeEntity: HomeEntity) {
        let highlightView = SeriesHighlightView(homeEntity: homeEntity)
        highlightView.fixInView(seriesHighlightView)
    }
}
