//
//  UILabel.swift
//  TVmaze
//
//  Created by Salvador on 12/19/21.
//

import UIKit

extension UILabel {
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(self.font!.pointSize)\">%@</span>",
                                  htmlText)
        
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html,
                      .characterEncoding:String.Encoding.utf8.rawValue],
            documentAttributes: nil)

        self.attributedText = attrStr
    }
}
