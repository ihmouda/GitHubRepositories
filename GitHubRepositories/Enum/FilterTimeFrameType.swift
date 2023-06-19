//
//  FilterTimeFrameType.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import Foundation

/**
 Represents the time frame types for filtering data.
 
 The `FilterTimeFrameType` enum defines different time frames that can be used for filtering data.
 */
enum FilterTimeFrameType: Int {
    
    case lastDay = 0
    case lastWeek
    case lastMonth
    
    /// The title representing the time frame.
    var title: String {
        switch self {
        case .lastDay:
            return "Last Day"
        case .lastWeek:
            return "Last Week"
        case .lastMonth:
            return "Last Month"
        }
    }
    
    /// The date representing the start of the time frame.
    var date: Date {
        
        var value: Int
        var component: Calendar.Component
        
        switch self {
        case .lastDay:
            component = .day
            value = -1
        case .lastWeek:
            component = .day
            value = -7
        case .lastMonth:
            component = .month
            value = -1
        }
        
        let date = Calendar.current.date(byAdding: component, value: value, to: Date())
        return date ?? Date()
    }
    
    /// An array containing all time frame types.
    static let all: [Self] = [.lastDay, .lastWeek, .lastMonth]
}

