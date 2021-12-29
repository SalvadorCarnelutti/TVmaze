//
//  UISearchController.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

import UIKit

extension UISearchController {
    var isSearchBarEmpty: Bool {
        return searchBar.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return isActive && !isSearchBarEmpty
    }
}
