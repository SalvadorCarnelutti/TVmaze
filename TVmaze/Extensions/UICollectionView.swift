//
//  UICollectionView.swift
//  TVmaze
//
//  Created by Salvador on 11/8/22.
//

import UIKit

extension UICollectionView {
    func register(_ collectionViewCell: UICollectionViewCell.Type) {
        register(UINib(nibName: collectionViewCell.identifier, bundle: .none),
                 forCellWithReuseIdentifier: collectionViewCell.identifier)
    }
}
