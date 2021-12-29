//
//  ZeroResultsSearch.swift
//  TVmaze
//
//  Created by Salvador on 12/18/21.
//

import UIKit

final class ZeroResultsSearch: UIViewNibLoadable {
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    func setupLabel(with messageText: String, image: UIImage? = nil) {
        messageLabel.text = messageText
        
        if let image = image {
            messageImage.image = image
        }
    }
}
