//
//  HomeView.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import UIKit

final class HomeView: UIViewNibLoadable {
    // MARK: IBOutlets
    @IBOutlet weak var homeTitle: UILabel! {
        didSet {
            homeTitle.text = "HomeTitle".localized()
            homeTitle.font = UIFont.boldSystemFont(ofSize: 36.0)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var zeroSeriesFoundView: UIView! {
        didSet {
            let zeroResultsSearch = ZeroResultsSearch()
            zeroResultsSearch.fixInView(zeroSeriesFoundView)
            zeroSeriesFoundView.isHidden = false
            tableView.isHidden = true
        }
    }
}
