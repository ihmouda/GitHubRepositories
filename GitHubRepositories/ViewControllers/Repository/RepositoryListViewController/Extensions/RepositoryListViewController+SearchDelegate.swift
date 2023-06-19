//
//  RepositoryListViewController+SearchDelegate.swift
//  GitHubRepositories
//
//  Created by mihmouda on 16/06/2023.
//

import UIKit

extension RepositoryListViewController: UISearchResultsUpdating {
    
    /// Notifies the view controller that the search results are being updated.
    ///
    /// - Parameter searchController: The search controller providing the updates.
    func updateSearchResults(for searchController: UISearchController) {
        if self.viewModel.isDataLoading || self.viewModel.isDataRequestFailed {
            return
        }
        
        self.viewModel.setSearchText(searchController.searchBar.text ?? "")
        self.tableView.reloadData()
    }
}

extension RepositoryListViewController: UISearchBarDelegate {
    
    /// Tells the delegate that the selected scope button index has changed.
    ///
    /// - Parameters:
    ///   - searchBar: The search bar that triggered the event.
    ///   - selectedScope: The index of the selected scope button.
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let selectedTimeFrame = FilterTimeFrameType(rawValue: selectedScope) ?? .lastDay
        self.viewModel.reset()
        self.viewModel.setSelectedTimeFrame(selectedTimeFrame)
        self.searchController.isActive = false
        self.tableView.reloadData()
        self.searchForRepositories()
    }
    
    /// Determines whether the search bar should begin editing.
    ///
    /// - Parameter searchBar: The search bar.
    /// - Returns: A Boolean value indicating whether editing should begin.
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsScopeBar = false
        searchBar.sizeToFit()
        return true
    }

    /// Determines whether the search bar should end editing.
    ///
    /// - Parameter searchBar: The search bar.
    /// - Returns: A Boolean value indicating whether editing should end.
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsScopeBar = true
        searchBar.sizeToFit()
        return true
    }
}
