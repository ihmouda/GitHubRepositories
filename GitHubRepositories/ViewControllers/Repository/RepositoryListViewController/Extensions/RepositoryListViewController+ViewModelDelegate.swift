//
//  RepositoryListViewController+ViewModelDelegate.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import Alamofire

extension RepositoryListViewController: RepositoryListViewModelProtocol {
    
    /// Reloads the table view data.
    func reloadTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    /// Shows an alert view indicating a failure to get data.
    func showFailedAlertView() {
        let action = AlertViewUtils.defineOptionAction(title: NSLocalizedString("general.ok", comment: "ok"), style: .cancel, completion: nil)
        AlertViewUtils.showAlert(title: nil ,message: NSLocalizedString("error.failedToGetData", comment: "failed to get"), actions: [action], viewController: self)
    }
}

