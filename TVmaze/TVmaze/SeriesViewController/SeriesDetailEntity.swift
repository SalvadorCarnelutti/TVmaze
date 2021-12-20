//
//  SeriesDetailEntity.swift
//  TVmaze
//
//  Created by Salvador on 12/19/21.
//

import Foundation

struct SeriesDetailEntity: Codable {
    let name: String
    let season: Int
    let number: Int
    let summary: String
    let image: Image?
    let rating: Rating
    
    var seriesInfo: [String] {
        return [String(number), name, String(rating.score)]
    }
}

struct Rating: Codable {
    let score: Double
    
    private enum CodingKeys : String, CodingKey {
        case score = "average"
    }
}
