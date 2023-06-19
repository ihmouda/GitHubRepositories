//
//  RepositoryListViewController+Delegate.swift
//  GitHubRepositories
//
//  Created by mihmouda on 16/06/2023.
//

import Foundation

extension RepositoryListViewController: RepositoryTableViewCellDelegate {
    
    /// Notifies the view controller that the favorite image in a repository table view cell was clicked.
    ///
    /// - Parameter indexPath: The index path of the cell where the favorite image was clicked.
    func repositoryTableViewCellDidClickFavoriteImage(at indexPath: IndexPath) {
        if let representable = self.viewModel.representableForRow(at: indexPath) as? RepositoryTableViewCellRepresentable {
            let repository = self.viewModel.getRepository(at: indexPath)
            let manager = GitHubRepositoryManager(repository: UserDefaultsGitHubRepository())
            
            if representable.isFavorite {
                self.viewModel.unFavoriteRepositoryUsingRepository(manager, repo: repository)
            } else {
                self.viewModel.favoriteRepositoryUsingRepository(manager, repo: repository)
            }
        }
        
        self.tableView.reloadData()
    }
}
