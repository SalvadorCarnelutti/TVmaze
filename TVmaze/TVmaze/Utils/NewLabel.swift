//
//  NewLabel.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import UIKit

final class StackLabel: UILabel {
    init(text: String, font: UIFont) {
        super.init(frame: CGRect.zero)
        self.text = text
        self.textAlignment = .left
        self.font = font
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
