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
    let airdate: String
    let rating: Rating
    let image: Image?
    
    var episodeColumnsInfo: [String] {
        var episodeColumns = [String(number), name]
        if let score = rating.score {
            episodeColumns.append(String(score))
        } else {
            episodeColumns.append("TBA")
        }
        
        return episodeColumns
    }
    
    var episodeDetailInfo: [String] {
        let episodeHeading = String(format: "SeriesEpisodeHeading".localized(), number, season)
        var episodeDetail = [name, episodeHeading]
        if let episodeAirdate = episodeAirdate {
            episodeDetail.append(String(format: "SeriesEpisodeAiringHeading".localized(), episodeAirdate))
        }
        
        return episodeDetail
    }
    
    var seriesImageURL: String? {
        return image?.medium
    }
    
    var episodeAirdate: String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        guard let date = dateFormatterGet.date(from: airdate) else {
            return nil
        }
        

        return date.getFormattedDate(format: "MMMM dd, yyyy")
    }
}

struct Rating: Codable {
    let score: Double?
    
    private enum CodingKeys : String, CodingKey {
        case score = "average"
    }
}
