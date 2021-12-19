//
//  ZeroResultsSearch.swift
//  TVmaze
//
//  Created by Salvador on 12/18/21.
//

import UIKit

final class ZeroResultsSearch: UIViewNibLoadable {
    @IBOutlet weak var messageLabel: UILabel! {
        didSet {
            messageLabel.text = "ZeroResultMessage".localized()
        }
    }
}
