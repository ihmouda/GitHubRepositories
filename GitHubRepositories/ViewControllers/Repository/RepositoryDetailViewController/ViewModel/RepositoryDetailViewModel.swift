//
//  RepositoryDetailViewModel.swift
//  GitHubRepositories
//
//  Created by mihmouda on 16/06/2023.
//

import UIKit

/**
 The view model class for the repository detail view.
 
 The `RepositoryDetailViewModel` class is responsible for providing the data and representables required to populate the repository detail view. It holds a reference to the `GitHubRepository` model and manages an array of `TableViewCellRepresentable` objects representing the repository's details.
 */
class RepositoryDetailViewModel {
    
    /// The array of representables for the repository's details.
    private(set) var representables: [TableViewCellRepresentable]
    
    /// The GitHub repository associated with this view model.
    private(set) var repository: GitHubRepository
 
    /**
     Initializes a new instance of `RepositoryDetailViewModel`.
     
     - Parameters:
        - repository: The GitHub repository to be displayed.
        - isFavorite: A boolean value indicating whether the repository is marked as a favorite.
     */
    init(repository: GitHubRepository, isFavorite: Bool) {
        
        self.repository = repository
        self.representables = []
        self.buildRepresentables(isFavorite: isFavorite)
    }
    
    /**
     Builds the representables array for the repository's details.
     
     - Parameter isFavorite: A boolean value indicating whether the repository is marked as a favorite.
     */
    func buildRepresentables(isFavorite: Bool) {
        
        // Remove all items
        self.representables.removeAll()
        
        // Build representable
        let representable = RepositoryTableViewCellRepresentable(repository: repository, indexPath: IndexPath(row: 0, section: 0), isFavorite: isFavorite)

        // Append representable
        self.representables.append(representable)
    }
    
    /**
     Returns the number of sections in the table view.
     
     - Returns: The number of sections in the table view.
     */
    func numberOfSections() -> Int {
        return 1
    }

    /**
     Returns the number of rows in the specified section of the table view.
     
     - Parameter section: The index of the section.
     - Returns: The number of rows in the specified section of the table view.
     */
    func numberOfRows(inSection section: Int) -> Int {
        return self.representables.count
    }

    /**
     Returns the height for the specified row in the table view.
     
     - Parameters:
        - indexPath: The index path of the row.
        - tableView: The table view in which the row is displayed.
     - Returns: The height for the specified row.
     */
    func heightForRow(at indexPath: IndexPath, tableView: UITableView ) -> CGFloat {
        return UITableView.automaticDimension
    }

    /**
     Returns the representable object for the specified row index path.
     
     - Parameter indexPath: The index path of the row.
     - Returns: The representable object for the specified row index path.
     */
    func representableForRow(at indexPath: IndexPath) -> TableViewCellRepresentable? {
        return self.representables[indexPath.row]
    }
}
