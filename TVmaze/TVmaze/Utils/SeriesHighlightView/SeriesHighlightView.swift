//
//  SeriesHighlightView.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import UIKit

enum HighlightStyling {
    case home
    case seriesDetail
    case episodeDetail
}

final class SeriesHighlightView: UIViewNibLoadable {
    // MARK: IBOutlets
    @IBOutlet weak var seriesImage: UIImageView! {
        didSet {
            seriesImage.applyShadow()
        }
    }
    
    @IBOutlet weak var shortInfoVerticalStackView: UIStackView!
    
    // MARK: Lifecycle methods
    init(homeEntity: HomeEntity, highlightStyling: HighlightStyling) {
        super.init(frame: CGRect.zero)
        setupSubviews(homeEntity: homeEntity, highlightStyling: highlightStyling)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    private(set) var request: DispatchWorkItem?
    
    private func setupSubviews(homeEntity: HomeEntity, highlightStyling: HighlightStyling) {
        loadInfoData(homeEntity: homeEntity, highlightStyling: highlightStyling)
        loadImage(homeEntity: homeEntity)
    }
    
    func loadInfoData(homeEntity: HomeEntity, highlightStyling: HighlightStyling) {
        let info = highlightStyling == .home ? homeEntity.homeInfo : homeEntity.seriesInfo
        for string in info.compactMap({ $0 }) {
            let isFirstString = homeEntity.homeInfo.first == string
            let label = StackLabel(text: string, font: UIFont.systemFont(ofSize: isFirstString ? 18 : 16,
                                                                         weight: isFirstString ? .bold : .regular))
            
            shortInfoVerticalStackView.addArrangedSubview(label)
        }
    }
    
    func loadImage(homeEntity: HomeEntity) {
        let placeholderImage = UIImage(systemName: "photo.artframe")
        request = seriesImage.loadImage(urlString: homeEntity.seriesImageURL, placeholderImage: placeholderImage!)
    }
}
