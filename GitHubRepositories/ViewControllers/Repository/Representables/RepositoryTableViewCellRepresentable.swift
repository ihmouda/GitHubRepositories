//
//  RepositoryTableViewCellRepresentable.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import UIKit

/**
 Represents a view model for a repository table view cell.
 
 The `RepositoryTableViewCellRepresentable` class represents a view model for a repository table view cell. It provides properties that hold the data to be displayed in the cell, such as the repository name, description, star count, fork count, URL path, owner information, and other relevant details.
 */
class RepositoryTableViewCellRepresentable: TableViewCellRepresentable {
    
    /// The height of the cell.
    var cellHeight: CGFloat
    
    /// The index path of the item data associated with the cell.
    var itemDataIndexPath: IndexPath
    
    /// The reuse identifier for the cell.
    var cellReuseIdentifier: String

    /// The name of the repository.
    var name: String = ""
    
    /// The description of the repository.
    var description: String?
    
    /// The count of stars the repository has.
    var starsCount: Int = 0
    
    /// The count of forks the repository has.
    var forksCount: Int = 0
    
    /// The programming language used in the repository.
    var language: String?
    
    /// The URL path of the repository.
    var urlPath: String = ""
    
    /// Indicates whether the repository is marked as a favorite.
    var isFavorite: Bool = false
    
    /// The name of the owner of the repository.
    var ownerName: String = ""
    
    /// The avatar path of the owner of the repository.
    var ownerAvatar: String?
    
    /// The creation date of the repository.
    var createdDate: Date?

    /**
     Initializes an instance of `RepositoryTableViewCellRepresentable`.
     
     - Note: This initializer sets default values for the properties.
     */
    init() {
        
        // Set default values
        self.cellHeight = RepositoryTableViewCell.getCellHeight()
        self.itemDataIndexPath = IndexPath(row: -1, section: -1)
        self.cellReuseIdentifier = RepositoryTableViewCell.getReuseIdentifier()
    }

    /**
     Initializes an instance of `RepositoryTableViewCellRepresentable` with the given repository and index path.
     
     - Parameters:
        - repository: The `GitHubRepository` object representing the repository.
        - indexPath: The index path of the item data associated with the cell.
        - isFavorite: Indicates whether the repository is marked as a favorite.
     */
    convenience init(repository: GitHubRepository, indexPath: IndexPath, isFavorite: Bool) {
        self.init()
        
        self.name = repository.name
        self.description = repository.description
        self.starsCount = repository.starsCount
        self.forksCount = repository.forksCount
        self.urlPath = repository.urlPath
        self.ownerName = repository.owner.name
        self.ownerAvatar = repository.owner.avatarPath
        self.language = repository.language
        self.isFavorite = isFavorite
        self.createdDate = DateUtils.getDateFromString(repository.createdAt, formatter: "yyyy-MM-dd'T'HH:mm:ss")
        self.itemDataIndexPath = indexPath
    }
}
