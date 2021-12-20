//
//  SeriesDetailCollectionViewCell.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

import UIKit

final class SeriesDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    func addBorder() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
    }
}
