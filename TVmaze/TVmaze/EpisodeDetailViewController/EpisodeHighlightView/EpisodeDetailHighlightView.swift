//
//  EpisodeDetailHighlightView.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

import UIKit

final class EpisodeDetailHighlightView: UIViewNibLoadable {
    // MARK: Properties
    private var request: DispatchWorkItem?
    
    // MARK: IBOutlets
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var infoStack: UIStackView!
    
    @IBOutlet weak var summaryLabelContainer: UIView! {
        didSet {
            summaryLabelContainer.backgroundColor = .caramel
            summaryLabelContainer.layer.cornerRadius = 12
        }
    }
    
    @IBOutlet weak var episodeSummaryLabel: UILabel!
    
    // MARK: Lifecycle methods
    init(detailHighlightInfo: DetailHighlightInfo, highlightCellInfo: HighlightCellInfo? = nil) {
        super.init(frame: CGRect.zero)
        setupSubviews(detailHighlightInfo: detailHighlightInfo, highlightCellInfo: highlightCellInfo)
    }
    
    private func setupSubviews(detailHighlightInfo: DetailHighlightInfo, highlightCellInfo: HighlightCellInfo?) {
        loadInfoData(infoText: detailHighlightInfo.highlightInfo.infoText)
        loadImage(imageURL: detailHighlightInfo.highlightInfo.imageURL)
        guard let seriesSummary = detailHighlightInfo.summary else {
            summaryLabelContainer.isHidden = true
            return
        }
        
        episodeSummaryLabel.setHTMLFromString(htmlText: seriesSummary)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadInfoData(infoText: [String]) {
        for string in infoText {
            let isFirstString = infoText.first == string
            let label = StackLabel(text: string, font: UIFont.systemFont(ofSize: isFirstString ? 18 : 16,
                                                                         weight: isFirstString ? .bold : .regular))
            
            infoStack.addArrangedSubview(label)
        }
    }
    
    private func loadImage(imageURL: String?) {
        guard let imageURL = imageURL,
        let placeholderImage = UIImage(systemName: "photo.artframe") else {
            episodeImageView.isHidden = true
            return
        }
        
        request = episodeImageView.loadImage(urlString: imageURL, placeholderImage: placeholderImage)
    }

}
