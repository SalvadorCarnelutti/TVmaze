//
//  ZeroResultsSearch.swift
//  TVmaze
//
//  Created by Salvador on 12/18/21.
//

import UIKit

final class ZeroResultsSearch: UIViewNibLoadable {
    @IBOutlet weak var messageLabel: UILabel!
    
    func setupView(with messageText: String) {
        messageLabel.text = messageText
    }
}
