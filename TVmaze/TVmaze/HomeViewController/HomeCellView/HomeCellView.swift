//
//  HomeCellView.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import UIKit

protocol PresenterToViewHomeProtocol: AnyObject {
    func setupCell(homeEntity: HomeEntity)
}

final class HomeCellView: UITableViewCell {
    // MARK: IBOutlets
    @IBOutlet weak var seriesHighlightView: UIView!
}

extension HomeCellView: PresenterToViewHomeProtocol {
    func setupCell(homeEntity: HomeEntity) {
        let highlightView = SeriesHighlightView(homeEntity: homeEntity)
        highlightView.fixInView(seriesHighlightView)
    }
}
