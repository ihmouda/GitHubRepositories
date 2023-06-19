//
//  ConfigurationManager.swift
//  GitHubRepositories
//
//  Created by mihmouda on 17/06/2023.
//

import Foundation

/// A singleton class responsible for managing the API configuration settings.
class ConfigurationManager {
    /// The configuration settings for the API.
    var configuration: Configuration?
    
    /// The shared instance of the ConfigurationManager.
    static let shared = ConfigurationManager()
    
    /// Initializes a new instance of the ConfigurationManager.
    private init() {
        guard let path = Bundle.main.path(forResource: "Configuration", ofType: "plist") else {
            return
        }
        
        guard let configurationDict: NSDictionary = NSDictionary(contentsOfFile: path) else {
            return
        }
        
        if let apiBaseUrl = configurationDict["APIBaseURL"] as? String {
            self.configuration = Configuration(apiBaseUrl: apiBaseUrl)
        }
    }
}

