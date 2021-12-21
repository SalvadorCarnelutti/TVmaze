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
    let summary: String?
    let image: Image?
    let rating: Rating
    
    var seriesInfo: [String] {
        var x = [String(number), name]
        if let score = rating.score {
            x.append(String(score))
        } else {
            x.append("TBA")
        }
        return x
    }
    
    var episodeInfo: [String] {
        return [name, "#\(number)", String(season)]
    }
    
    var seriesImageURL: String {
        return image?.medium ?? ""
    }
}

struct Rating: Codable {
    let score: Double?
    
    private enum CodingKeys : String, CodingKey {
        case score = "average"
    }
}
