//
//  SeriesEntity.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

struct HomeEntity {
    let series: Series
    
    var seriesImageURL: String {
        return series.image.medium
    }
    
    var shortInfo: [String] {
        return [series.name, series.status, series.genres.joined(separator: ", ")]
    }
}

struct FilteredSeries: Codable {
    let series: Series
    
    private enum CodingKeys : String, CodingKey {
        case series = "show"
    }
}

struct Series: Codable {
    let name: String
    let genres: [String]
    let status: String
    let schedule: Schedule
    let summary: String
    let image: Image
}

struct Schedule: Codable {
    let time: String
    let days: [String]
}

struct Image: Codable {
    let medium: String
}
