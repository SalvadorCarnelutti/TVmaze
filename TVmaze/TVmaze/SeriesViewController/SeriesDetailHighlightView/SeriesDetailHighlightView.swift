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
        let seriesHightlightView = SeriesHighlightView(homeEntity: homeEntity, highlightStyling: highlightStyling)
        seriesHightlightView.fixInView(seriesHighlightView)
        if let seriesSummary = homeEntity.series.summary {
            
        }
        seriesSummaryLabel.setHTMLFromString(htmlText: homeEntity.series.summary!)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
