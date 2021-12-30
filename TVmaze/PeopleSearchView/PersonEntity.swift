//
//  PersonEntity.swift
//  TVmaze
//
//  Created by Salvador on 12/22/21.
//

import Foundation

struct PersonEntity: Codable {
    let person: Person
    
    var name: String {
        return person.name
    }
    
    var personImageURL: String? {
        return person.image?.medium
    }
}

struct Person: Codable {
    let id: Int
    let name: String
    let image: Image?
}
