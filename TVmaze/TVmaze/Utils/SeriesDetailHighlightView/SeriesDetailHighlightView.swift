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
    init(infoText: [String], imageURL: String, summary: String?) {
        super.init(frame: CGRect.zero)
        setupSubviews(infoText: infoText, imageURL: imageURL, summary: summary)
    }
    
    private func setupSubviews(infoText: [String], imageURL: String, summary: String?) {
        let seriesHightlightView = SeriesHighlightView(infoText: infoText, imageURL: imageURL)
        seriesHightlightView.fixInView(seriesHighlightView)

        guard let seriesSummary = summary else {
            summaryLabelContainer.isHidden = true
            return
        }
        
        seriesSummaryLabel.setHTMLFromString(htmlText: seriesSummary)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
