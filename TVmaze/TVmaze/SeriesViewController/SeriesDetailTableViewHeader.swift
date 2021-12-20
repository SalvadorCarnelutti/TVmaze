//
//  SeriesDetailTableViewHeader.swift
//  TVmaze
//
//  Created by Salvador on 12/19/21.
//

import UIKit

final class SeriesDetailTableViewHeader: UITableViewHeaderFooterView {
    // MARK: IBOutlets
    @IBOutlet weak var headerTitle: UILabel! {
        didSet {
            headerTitle.font =  UIFont.systemFont(ofSize: 18, weight: .bold)
        }
    }
    
    // MARK: Class methods
    func setupHeader(with section: Int) {
        headerTitle.text = String(format: "SeriesDetailTableViewHeaderTitle".localized(), String(section.advanced(by: 1)))
    }
}
