//
//  SeriesDetailCollectionView.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

import UIKit

final class SeriesDetailCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setup() {
        dataSource = self
        delegate = self
        register(UINib(nibName: SeriesDetailCollectionViewCell.identifier, bundle: .none),
                 forCellWithReuseIdentifier: SeriesDetailCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: SeriesDetailCollectionViewCell.identifier, for: indexPath) as? SeriesDetailCollectionViewCell else {
            SeriesDetailCollectionViewCell.assertCellFailure()
            return UICollectionViewCell()
        }
        
        cell.addBorder()
        
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//UICollectionViewDelegateFlowLayout methods
//func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
//{
//
//    return 4;
//}
//func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
//{
//
//    return 1;
//}
//
//
////UICollectionViewDatasource methods
//func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//
//    return 1
//}
//
//func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    return 100
//}
//
//func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell
//
//    cell.backgroundColor = self.randomColor()
//
//
//    return cell
//}

extension SeriesDetailCollectionView {
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

