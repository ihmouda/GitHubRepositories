//
//  DateUtils.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import Foundation

class DateUtils: NSObject {

   /**
    Converts a date to a string using the specified date format.
    
    - Parameters:
       - date: The date to be converted.
       - formatter: The date format string.
    - Returns: The string representation of the date.
    */
   static func getDateStringFrom(_ date: Date, formatter: String)-> String {
       
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = formatter
       let dateString = dateFormatter.string(from: date)
       return dateString
   }
   
   /**
    Converts a string to a date using the specified date format.
    
    - Parameters:
       - text: The string to be converted.
       - formatter: The date format string.
    - Returns: The date representation of the string, or `nil` if the conversion fails.
    */
   static func getDateFromString(_ text: String, formatter: String)-> Date? {
       
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = formatter
       let date = dateFormatter.date(from: text)
       return date
   }
}
