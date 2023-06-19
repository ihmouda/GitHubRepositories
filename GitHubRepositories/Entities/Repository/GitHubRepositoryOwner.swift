//
//  RepositoryOwner.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import UIKit

/**
 Represents the owner of a GitHub repository.
 
 The `GitHubRepositoryOwner` struct represents the owner of a GitHub repository with properties describing the owner's details.
 */
struct GitHubRepositoryOwner: Codable {
    
    /// The name of the repository owner.
    let name: String
    
    /// The avatar path of the repository owner.
    let avatarPath: String?
    
    /// The coding keys to map between the struct's properties and the keys in the JSON representation.
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarPath = "avatar_url"
    }
}
