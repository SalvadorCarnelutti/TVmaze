//
//  SeriesHighlightView.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import UIKit

struct HighlightInfo {
    let infoText: [String]
    let imageURL: String?
    let isFavorited: Bool
}

struct HighlightCellInfo {
    let indexPath: IndexPath
    let cellClosure: ((IndexPath) -> ())
    let insideCell: Bool
}

final class SeriesHighlightView: UIViewNibLoadable, UIGestureRecognizerDelegate {
    // MARK: Properties
    private var request: DispatchWorkItem?
    private var isFavorited: Bool
    private let highlightCellInfo: HighlightCellInfo?

    // MARK: IBOutlets
    @IBOutlet weak var seriesImage: UIImageView! {
        didSet {
            seriesImage.applyShadow()
        }
    }
    
    @IBOutlet weak var shortInfoVerticalStackView: UIStackView!
    @IBOutlet weak var favoriteStatusBar: UIView!
    @IBOutlet weak var favoriteStatusContainer: UIView!
    
    @IBOutlet weak var favoriteStatusImage: UIImageView! {
        didSet {
            favoriteStatusImage.isUserInteractionEnabled = true
        }
    }
    
    // MARK: Lifecycle methods
    init(highlightInfo: HighlightInfo, highlightCellInfo: HighlightCellInfo?) {
        isFavorited = highlightInfo.isFavorited
        self.highlightCellInfo = highlightCellInfo
        super.init(frame: CGRect.zero)
        setupSubviews(highlightInfo: highlightInfo, showFavoriteStatusBar: highlightCellInfo != nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: Class methods
    private func setupSubviews(highlightInfo: HighlightInfo, showFavoriteStatusBar: Bool = true) {
        loadInfoData(infoText: highlightInfo.infoText)
        loadImage(imageURL: highlightInfo.imageURL)
        displayFavoriteStatus(isFavorited: highlightInfo.isFavorited, showFavoriteStatusBar: showFavoriteStatusBar)
        let favoriteTap = UITapGestureRecognizer(target: self, action: #selector(self.handleFavoriteTap))
        favoriteStatusImage.addGestureRecognizer(favoriteTap)
    }
    
    private func loadInfoData(infoText: [String]) {
        for string in infoText {
            let isFirstString = infoText.first == string
            let label = StackLabel(text: string, font: UIFont.systemFont(ofSize: isFirstString ? 18 : 16,
                                                                         weight: isFirstString ? .bold : .regular))
            
            shortInfoVerticalStackView.addArrangedSubview(label)
        }
    }
    
    private func loadImage(imageURL: String?) {
        guard let imageURL = imageURL,
        let placeholderImage = UIImage(systemName: "person.crop.artframe") else {
            seriesImage.image = UIImage(systemName: "person.crop.artframe") 
            return
        }
        request = seriesImage.loadImage(urlString: imageURL, placeholderImage: placeholderImage)
    }
    
    private func displayFavoriteStatus(isFavorited: Bool, showFavoriteStatusBar: Bool) {
        guard showFavoriteStatusBar else {
            favoriteStatusBar.isHidden = true
            return
        }
        
        UIView.animate(withDuration: 0.18, delay: 0.0, options: .curveEaseOut, animations: {
            let imageSystemName = isFavorited ? "star.fill" : "star"
            self.favoriteStatusImage.image = UIImage(systemName: imageSystemName)
            
            self.favoriteStatusContainer.backgroundColor = isFavorited ? .caramel : .clear
        })
    }
    
    private func changeFavoriteStatus() {
        isFavorited.toggle()
        let imageSystemName = isFavorited ? "star.fill" : "star"
        self.favoriteStatusImage.image = UIImage(systemName: imageSystemName)
        
        self.favoriteStatusContainer.backgroundColor = isFavorited ? .caramel : .clear
    }
    
    @objc func handleFavoriteTap() {
        guard let highlightCellInfo = highlightCellInfo else {
            return
        }
        
        highlightCellInfo.cellClosure(highlightCellInfo.indexPath)

        if !highlightCellInfo.insideCell {
            changeFavoriteStatus()
        }
    }
}
