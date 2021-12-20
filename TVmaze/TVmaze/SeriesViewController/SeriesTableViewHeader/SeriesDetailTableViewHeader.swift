//
//  SeriesDetailTableViewHeader.swift
//  TVmaze
//
//  Created by Salvador on 12/19/21.
//

import UIKit

final class SeriesDetailTableViewHeader: UITableViewHeaderFooterView {
    // MARK: IBOutlets
    @IBOutlet weak var headerTitleContainer: UIView! {
        didSet {
            headerTitleContainer.backgroundColor = .caramel
        }
    }
    
    
    @IBOutlet weak var headerTitle: UILabel! {
        didSet {
            headerTitle.font =  UIFont.systemFont(ofSize: 24, weight: .bold)
        }
    }
    
    @IBOutlet weak var seriesDetailCollectionViewContainer: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerTitleContainer.roundCorners([.topLeft, .topRight], radius: 12.0)
    }
    
    // MARK: Class methods
    func setupHeader(with section: Int) {
        headerTitle.text = String(format: "SeriesDetailTableViewHeaderTitle".localized(), section)
        let layout = UICollectionViewFlowLayout()
        let collectionView = SeriesDetailCollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.fixInView(seriesDetailCollectionViewContainer)
        collectionView.setup(with: ["#", "SeriesNameColumnHeading".localized(), "SeriesNameScoreHeading".localized()])
    }
}
