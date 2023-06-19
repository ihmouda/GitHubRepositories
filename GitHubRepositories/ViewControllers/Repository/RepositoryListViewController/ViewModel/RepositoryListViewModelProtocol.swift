//
//  RepositoryListViewModelProtocol.swift
//  GitHubRepositories
//
//  Created by mihmouda on 18/06/2023.
//

import Foundation

// Protocol used for communication between the view and the view model.
protocol RepositoryListViewModelProtocol: NSObjectProtocol {
    
    // Notifies the view to reload its table view.
    func reloadTableView()
    
    // Notifies the view to show an alert view indicating a failure.
    func showFailedAlertView()
}
