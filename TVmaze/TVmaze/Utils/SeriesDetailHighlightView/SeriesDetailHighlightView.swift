//
//  SeriesDetailHighlightView.swift
//  TVmaze
//
//  Created by Salvador on 12/19/21.
//

import UIKit

struct DetailHighlightInfo {
    let highlightInfo: HighlightInfo
    let summary: String?
}

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
    init(detailHighlightInfo: DetailHighlightInfo, highlightCellInfo: HighlightCellInfo? = nil) {
        super.init(frame: CGRect.zero)
        setupSubviews(detailHighlightInfo: detailHighlightInfo, highlightCellInfo: highlightCellInfo)
    }
    
    // MARK: Class methods
    private func setupSubviews(detailHighlightInfo: DetailHighlightInfo, highlightCellInfo: HighlightCellInfo?) {
        let seriesHightlightView = SeriesHighlightView(highlightInfo: detailHighlightInfo.highlightInfo,
                                                       highlightCellInfo: highlightCellInfo)
        seriesHightlightView.fixInView(seriesHighlightView)
        
        guard let seriesSummary = detailHighlightInfo.summary else {
            summaryLabelContainer.isHidden = true
            return
        }
        
        seriesSummaryLabel.setHTMLFromString(htmlText: seriesSummary)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
