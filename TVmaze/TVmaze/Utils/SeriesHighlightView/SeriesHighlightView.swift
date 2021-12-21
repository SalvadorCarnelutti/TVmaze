//
//  SeriesHighlightView.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import UIKit

final class SeriesHighlightView: UIViewNibLoadable {
    // MARK: IBOutlets
    @IBOutlet weak var seriesImage: UIImageView! {
        didSet {
            seriesImage.applyShadow()
        }
    }
    
    @IBOutlet weak var shortInfoVerticalStackView: UIStackView!
    
    // MARK: Lifecycle methods
    init(infoText: [String], imageURL: String?) {
        super.init(frame: CGRect.zero)
        setupSubviews(infoText: infoText, imageURL: imageURL)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    private(set) var request: DispatchWorkItem?
    
    private func setupSubviews(infoText: [String], imageURL: String?) {
        loadInfoData(infoText: infoText)
        loadImage(imageURL: imageURL)
    }
    
    func loadInfoData(infoText: [String]) {
        for string in infoText {
            let isFirstString = infoText.first == string
            let label = StackLabel(text: string, font: UIFont.systemFont(ofSize: isFirstString ? 18 : 16,
                                                                         weight: isFirstString ? .bold : .regular))
            
            shortInfoVerticalStackView.addArrangedSubview(label)
        }
    }
    
    func loadImage(imageURL: String?) {
        guard let imageURL = imageURL else {
            seriesImage.isHidden = true
            return
        }
        
        let placeholderImage = UIImage(systemName: "photo.artframe")
        request = seriesImage.loadImage(urlString: imageURL, placeholderImage: placeholderImage!)
    }
}
