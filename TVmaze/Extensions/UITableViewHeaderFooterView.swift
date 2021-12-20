//
//  UITableViewHeaderFooterView.swift
//  TVmaze
//
//  Created by Salvador on 12/19/21.
//

import UIKit

extension UITableViewHeaderFooterView {
    static var identifier: String {
        String(describing: self)
    }
    
    static func assertHeaderFailure() {
        assertionFailure("There was an issue creating the \(self.identifier) header")
    }
    
    static func assertFooterFailure() {
        assertionFailure("There was an issue creating the \(self.identifier) footer")
    }
}
