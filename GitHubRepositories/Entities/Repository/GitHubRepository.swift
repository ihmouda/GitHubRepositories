//
//  Repository.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import Foundation

/**
 Represents a GitHub repository.
 
 The `GitHubRepository` struct represents a GitHub repository with various properties describing the repository's details.
 */
struct GitHubRepository: Codable, Equatable {
    
    /// The unique identifier of the repository.
    let id: Int
    
    /// The name of the repository.
    let name: String
    
    /// The description of the repository.
    let description: String?
    
    /// The programming language used in the repository.
    let language: String?
    
    /// The number of stars (or favorites) that the repository has.
    let starsCount: Int
    
    /// The number of forks (or copies) of the repository.
    let forksCount: Int
    
    /// The URL path of the repository.
    let urlPath: String
    
    /// The creation date of the repository.
    let createdAt: String
    
    /// The owner of the repository.
    let owner: GitHubRepositoryOwner

    /// The coding keys to map between the struct's properties and the keys in the JSON representation.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case language
        case starsCount = "stargazers_count"
        case forksCount = "forks_count"
        case urlPath = "html_url"
        case createdAt = "created_at"
        case owner
    }
    
    /**
     Determines the equality of two `GitHubRepository` instances.
     
     - Parameters:
        - lhs: The left-hand side `GitHubRepository` instance.
        - rhs: The right-hand side `GitHubRepository` instance.
     
     - Returns: `true` if the two instances are equal based on their `id` properties, otherwise `false`.
     */
    static func ==(lhs: GitHubRepository, rhs: GitHubRepository) -> Bool {
        return lhs.id == rhs.id
    }
}
