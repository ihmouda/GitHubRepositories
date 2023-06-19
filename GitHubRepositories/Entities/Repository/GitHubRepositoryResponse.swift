//
//  RepositoryResult.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import Foundation

/**
 Represents a response from the GitHub repository API.
 
 The `GitHubRepositoryResponse` struct represents a response from the GitHub repository API, containing the total count of repositories and an array of `GitHubRepository` objects.
 */
struct GitHubRepositoryResponse: Decodable {
    
    /// The total count of repositories.
    let totalCount: Int
    
    /// An array of `GitHubRepository` objects representing individual repositories.
    let items: [GitHubRepository]
    
    /// The coding keys to map between the struct's properties and the keys in the JSON representation.
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
