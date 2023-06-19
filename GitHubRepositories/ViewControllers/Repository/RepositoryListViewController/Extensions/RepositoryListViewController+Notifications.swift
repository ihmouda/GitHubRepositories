//
//  RepositoryListViewController+Notifications.swift
//  GitHubRepositories
//
//  Created by mihmouda on 17/06/2023.
//

import Foundation

extension RepositoryListViewController {
    
    /// Adds the necessary notifications for monitoring internet connectivity.
    func addNotifications() {
        NotificationCenter.default.removeObserver(self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleNotifictions(_:)), name:NSNotification.Name(rawValue: NetworkingManagerNotifications.connectedToInternet.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleNotifictions(_:)), name:NSNotification.Name(rawValue: NetworkingManagerNotifications.notConnectedToInternet.rawValue), object: nil)
    }
    
    /// Handles the notifications related to internet connectivity.
    ///
    /// - Parameter notification: The received notification.
    @objc func handleNotifictions(_ notification: Notification) {
        // Check if there is no internet connection
        if notification.name.rawValue == NetworkingManagerNotifications.notConnectedToInternet.rawValue {
            self.internetConnectionLost()
        }
        // Check if the internet connection has come back
        else if notification.name.rawValue == NetworkingManagerNotifications.connectedToInternet.rawValue {
            self.internetConnectionComeback()
        }
    }
    
    /// Handles the scenario when the internet connection is lost.
    func internetConnectionLost() {
        // Handle no internet connection
        if self.viewModel.handleNoInternetConnection() {
            self.tableView.reloadData()
        } else {
            let action = AlertViewUtils.defineOptionAction(title: NSLocalizedString("general.ok", comment: "ok"), style: .cancel, completion: nil)
            
            AlertViewUtils.showAlert(title: nil ,message: NSLocalizedString("error.noInternetConnection", comment: "no internet connection"), actions: [action], viewController: self)
        }
    }
    
    /// Handles the scenario when the internet connection comes back.
    func internetConnectionComeback() {
        // Check if the first representable is a network error representable
        if let representable = self.viewModel.representableForRow(at: IndexPath(row: 0, section: 0)) as? GeneralResourceTableViewCellRepresentable, representable.type == GeneralResourceType.networkError {
            // Reload data
            self.viewModel.reset()
            self.tableView.reloadData()
            self.viewModel.getRepositoriesUsingRepository(GitHubRepositoryManager(repository: RemoteGitHubRepository()), reloadData: true)
        } else {
            AlertViewUtils.hideAlertController()
        }
    }
}
