//
//  SeriesDetailTableViewHeader.swift
//  TVmaze
//
//  Created by Salvador on 12/19/21.
//

import UIKit

final class SeriesDetailTableViewHeader: UITableViewHeaderFooterView {
    // MARK: IBOutlets
    @IBOutlet weak var headerTitle: UILabel! {
        didSet {
            headerTitle.font =  UIFont.systemFont(ofSize: 20, weight: .bold)
        }
    }
    
    @IBOutlet weak var testView: UIView!
    
    // MARK: Class methods
    func setupHeader(with section: Int) {
        headerTitle.text = String(format: "SeriesDetailTableViewHeaderTitle".localized(), String(section.advanced(by: 1)))
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = SeriesDetailCollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.fixInView(testView)
        collectionView.setup()
    }
}
