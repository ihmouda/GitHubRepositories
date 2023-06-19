//
//  GeneralResource.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import UIKit

/// An enumeration representing different types of general resources.
enum GeneralResourceType {
    case loading
    case networkError
    case empty
}

/// A structure representing a general resource.
struct GeneralResource {
    /// The name of the image associated with the resource.
    let imageName: String?
    
    /// The type of the general resource.
    let type: GeneralResourceType
}
