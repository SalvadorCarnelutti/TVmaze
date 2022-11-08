//
//  UITableView.swift
//  TVmaze
//
//  Created by Salvador on 11/8/22.
//

import UIKit

extension UITableView {
    func register(_ tableViewCell: UITableViewCell.Type) {
        register(UINib(nibName: tableViewCell.identifier, bundle: .none),
                           forCellReuseIdentifier: tableViewCell.identifier)
    }
    
    func register(_ tableViewCell: UITableViewHeaderFooterView.Type) {
        register(UINib(nibName: tableViewCell.identifier, bundle: .none),
                 forHeaderFooterViewReuseIdentifier: tableViewCell.identifier)
    }
}
