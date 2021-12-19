//
//  SeriesHighlightView.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import UIKit

final class SeriesHighlightView: UIViewNibLoadable {
    // MARK: IBOutlets
    @IBOutlet weak var seriesImage: UIImageView!
    
    @IBOutlet weak var shortInfoVerticalStackView: UIStackView!
    
    init(homeEntity: HomeEntity) {
        super.init(frame: CGRect.zero)
        loadShortInfoData(homeEntity: homeEntity)
        loadImage(homeEntity: homeEntity)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    private(set) var request: DispatchWorkItem?
    
    func loadShortInfoData(homeEntity: HomeEntity) {
        for string in homeEntity.shortInfo {
            let isFirstString = homeEntity.shortInfo.first == string
            let label = StackLabel(text: string, font: UIFont.systemFont(ofSize: isFirstString ? 16 : 14,
                                                                         weight: isFirstString ? .bold : .regular))
            
            shortInfoVerticalStackView.addArrangedSubview(label)
        }
    }
    
    func loadImage(homeEntity: HomeEntity) {
        let placeholderImage = UIImage(systemName: "photo.artframe")
        request = seriesImage.loadImage(urlSting: homeEntity.seriesImageURL, placeholderImage: placeholderImage!)
    }
}

extension UILabel {
    
}
