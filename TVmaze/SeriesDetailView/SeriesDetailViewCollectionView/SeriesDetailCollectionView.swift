//
//  SeriesDetailCollectionView.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

import UIKit

final class SeriesDetailCollectionView: UICollectionView {
    // MARK: Properties
    private var columnTexts: [String] = []
    
    private var episodeNumberCellWidth: CGFloat {
        return bounds.width*(2/15)
    }
    
    private var episodeNameCellWidth: CGFloat {
        return bounds.width*(10/15)
    }
    
    private var episodeScoreCellWidth: CGFloat {
        return bounds.width*(3/15)
    }
    
    // MARK: Class methods
    func setup(with columnsText: [String]) {
        self.columnTexts = columnsText
        setupCollection()
    }
    
    private func setupCollection() {
        dataSource = self
        delegate = self
        isScrollEnabled = false
        isUserInteractionEnabled = false
        register(SeriesDetailCollectionViewCell.self)
    }
}

// MARK: CollectionView methods
extension SeriesDetailCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columnTexts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: SeriesDetailCollectionViewCell.identifier, for: indexPath) as? SeriesDetailCollectionViewCell else {
            SeriesDetailCollectionViewCell.assertCellFailure()
            return UICollectionViewCell()
        }
        
        let columnText = columnTexts[indexPath.row]
        cell.setupCell(with: columnText)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = bounds.height
        switch indexPath.row {
        case 0:
            return CGSize(width: episodeNumberCellWidth, height: cellHeight)
        case 1:
            return CGSize(width: episodeNameCellWidth, height: cellHeight)
        default:
            return CGSize(width: episodeScoreCellWidth, height: cellHeight)
        }
    }
}
