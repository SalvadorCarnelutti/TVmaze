//
//  SeriesEntity.swift
//  TVmaze
//
//  Created by Salvador on 12/17/21.
//

import Foundation

struct HomeEntity {
    let series: Series
    private(set) var isFavorited: Bool = false
    
    var seriesImageURL: String? {
        return series.image?.medium
    }
    
    var homeInfo: [String] {
        return [series.name, series.genres.joined(separator: ", "), series.status]
    }
    
    var seriesInfo: [String?] {
        return [series.name, series.genres.joined(separator: ", "), schedule, series.status]
    }
    
    var schedule: String? {
        let days = series.schedule.days
        let time = series.schedule.time
        
        switch (series.schedule.days.count, series.schedule.time)  {
        case (0, ""):
            return nil
        case (0, _):
            return "\("ScheduleTimePrefix".localized().capitalized) \(time)"
        case (_, ""):
            return "\("ScheduleDaysPrefix".localized()) \(joinedDays(days: days))"
        case (_, _):
            return "\("ScheduleDaysPrefix".localized()) \(joinedDays(days: days)) \("ScheduleTimePrefix".localized()) \(time)"
        }
    }
    
    private func joinedDays(days: [String]) -> String {
        if days.count <= 1 {
            return days.joined()
        } else {
            let lastDay = days.last
            let allDays = days.dropLast().joined(separator: ", ") + " and " + lastDay!
            return allDays
        }
    }
    
    mutating func toggleFavoriteStatus() {
        isFavorited.toggle()
    }
    
    mutating func resetFavoriteStatus() {
        isFavorited = false
    }
}

extension HomeEntity {
    var homeHighlightInfo: HighlightInfo {
        return HighlightInfo(infoText: homeInfo,
                             imageURL: seriesImageURL,
                             isFavorited: isFavorited)
    }
    
    var seriesDetailHighlightInfo: DetailHighlightInfo {
        return DetailHighlightInfo(highlightInfo: homeHighlightInfo,
                                   summary: series.summary)
    }
}

struct FilteredSeries: Codable {
    let series: Series
    
    private enum CodingKeys : String, CodingKey {
        case series = "show"
    }
}

struct Series: Codable {
    let id: Int
    let name: String
    let genres: [String]
    let status: String
    let schedule: Schedule
    let summary: String?
    let image: Image?
}

struct Schedule: Codable {
    let time: String
    let days: [String]
}

struct Image: Codable {
    let medium: String?
}
