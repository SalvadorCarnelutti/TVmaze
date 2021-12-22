//
//  PINNumberDisplayerView.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

import UIKit

final class PINNumberDisplayerView: UIViewNibLoadable {
    private let numberDigitLength: Int = 4
    private var imagesViews: [UIImageView] = []
    
    @IBOutlet weak var firstDigitImage: UIImageView!
    @IBOutlet weak var secondDigitImage: UIImageView!
    @IBOutlet weak var thirdDigitImage: UIImageView!
    @IBOutlet weak var fourthDigitImage: UIImageView!
    
    func setupImages() {
        imagesViews = [firstDigitImage, secondDigitImage, thirdDigitImage, fourthDigitImage]
        imagesViews.forEach { $0.contentMode = .scaleAspectFit }
        imagesViews.forEach { $0.image = UIImage(systemName: "square") }
        imagesViews.forEach { $0.tintColor = .systemBlue }
    }
    
    func updateWith(stringNumber: String) {
        guard stringNumber.count <= numberDigitLength else {
            return
        }
                
        for pinIndex in 0..<numberDigitLength {
            let systemName = pinIndex <= stringNumber.count.advanced(by: -1) ?
            "\(stringNumber[pinIndex]).square" : "square"
            imagesViews[pinIndex].image = UIImage(systemName: systemName)
        }
        
        imagesViews.forEach {$0.tintColor = .systemBlue}
    }
    
    func displayAsIncorrect() {
        imagesViews.forEach {$0.tintColor = .crimson}
    }
}
