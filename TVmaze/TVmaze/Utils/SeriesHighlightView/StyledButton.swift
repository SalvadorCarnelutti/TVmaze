//
//  StyledButton.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

import UIKit

final class StyledButton: UIButton {
    func styleAs(enabled: Bool) {
        isEnabled = enabled
        backgroundColor = enabled ? .caramel : .lightGray
        setTitleColor(.black, for: .normal)
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}
