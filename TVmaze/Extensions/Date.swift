//
//  Date.swift
//  TVmaze
//
//  Created by Salvador on 12/20/21.
//

import Foundation

extension Date {
    func getFormattedDate(format: String) -> String {
         let dateformat = DateFormatter()
         dateformat.dateFormat = format
         return dateformat.string(from: self)
     }
}
