//
//  SeriesDetailCollectionViewCell.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

import UIKit

final class SeriesDetailCollectionViewCell: UICollectionViewCell {
    // MARK: IBOutlets
    @IBOutlet weak var label: UILabel!
    
    // MARK: Class methods
    func setupCell(with columnText: String) {
        label.text = columnText
        addGridBorder()
    }
    
    private func addGridBorder() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
    }
}
