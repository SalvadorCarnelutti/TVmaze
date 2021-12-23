//
//  PeopleSearchCellView.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

import UIKit

final class PeopleSearchCellView: UITableViewCell {
    // MARK: Properties
    private var request: DispatchWorkItem?

    // MARK: IBOutlets
    @IBOutlet weak var personImage: UIImageView! {
        didSet {
            personImage.applyShadow()
        }
    }
    
    @IBOutlet weak var personName: UILabel! {
        didSet {
            personName.font = UIFont.boldSystemFont(ofSize: 18)
        }
    }
    
    // MARK: Class methods
    func setupCell(with personEntity: PersonEntity) {
        personName.text = personEntity.name
        loadImage(imageURL: personEntity.personImageURL)
    }

    private func loadImage(imageURL: String?) {
        guard let imageURL = imageURL,
        let placeholderImage = UIImage(systemName: "photo.artframe") else {
            personImage.isHidden = true
            return
        }
        
        request = personImage.loadImage(urlString: imageURL, placeholderImage: placeholderImage)
    }
}
