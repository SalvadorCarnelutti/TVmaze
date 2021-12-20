//
//  SeriesCellView.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

import UIKit

final class SeriesCellView: UITableViewCell {
    // MARK: Class methods
    func setupCell(with seriesDetailEntity: SeriesDetailEntity) {
        let layout = UICollectionViewFlowLayout()
        let collectionView = SeriesDetailCollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.fixInView(contentView)
        collectionView.setup(with: seriesDetailEntity.seriesInfo)
    }
}
