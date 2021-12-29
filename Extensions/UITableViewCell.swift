//
//  UITableViewCell.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
    
    static func assertCellFailure() {
        assertionFailure("There was an issue creating the \(self.identifier) cell")
    }
}
