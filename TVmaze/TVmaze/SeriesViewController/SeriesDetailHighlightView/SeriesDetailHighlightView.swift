//
//  SeriesDetailHighlightView.swift
//  TVmaze
//
//  Created by Salvador on 12/19/21.
//

import UIKit

final class SeriesDetailHighlightView: UIViewNibLoadable {
    // MARK: IBOutlets
    @IBOutlet weak var seriesHighlightView: UIView!
    
    @IBOutlet weak var summaryLabelContainer: UIView! {
        didSet {
            summaryLabelContainer.backgroundColor = .caramel
            summaryLabelContainer.layer.cornerRadius = 12
        }
    }
    
    @IBOutlet weak var seriesSummaryLabel: UILabel!
    
    // MARK: Lifecycle methods
    init(homeEntity: HomeEntity, highlightStyling: HighlightStyling) {
        super.init(frame: CGRect.zero)
        setupSubviews(homeEntity: homeEntity, highlightStyling: highlightStyling)
    }
    
    private func setupSubviews(homeEntity: HomeEntity, highlightStyling: HighlightStyling) {
        let seriesHightlightView = SeriesHighlightView(homeEntity: homeEntity, highlightStyling: highlightStyling)
        seriesHightlightView.fixInView(seriesHighlightView)

        guard let seriesSummary = homeEntity.series.summary else {
            summaryLabelContainer.isHidden = true
            return
        }
        
        seriesSummaryLabel.setHTMLFromString(htmlText: seriesSummary)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
