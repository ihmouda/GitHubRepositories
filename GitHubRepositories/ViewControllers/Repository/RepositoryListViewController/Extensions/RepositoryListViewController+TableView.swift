//
//  RepositoryListViewController+TableView.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import UIKit

extension RepositoryListViewController: UITableViewDataSource, UITableViewDelegate {
    
    /// Returns the number of sections in the table view.
    ///
    /// - Parameter tableView: The table view requesting this information.
    /// - Returns: The number of sections in the table view.
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections()
    }

    /// Returns the number of rows in the specified section of the table view.
    ///
    /// - Parameters:
    ///   - tableView: The table view requesting this information.
    ///   - section: The index of the section.
    /// - Returns: The number of rows in the specified section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows(inSection: section)
    }

    /// Returns a cell to insert in the table view at the specified index path.
    ///
    /// - Parameters:
    ///   - tableView: The table view requesting this information.
    ///   - indexPath: The index path that specifies the location of the cell.
    /// - Returns: A configured table view cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellRepresentable = self.viewModel.representableForRow(at: indexPath)
        
        if let generalResource = cellRepresentable as? GeneralResourceTableViewCellRepresentable {
            if generalResource.type == GeneralResourceType.loading {
                if let loadingTableViewCell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.getReuseIdentifier(), for: indexPath) as? LoadingTableViewCell {
                    loadingTableViewCell.setup(color: .gray)
                    return loadingTableViewCell
                }
            } else {
                if let emptyTableViewCell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.getReuseIdentifier(), for: indexPath) as? EmptyTableViewCell {
                    emptyTableViewCell.setup(image: UIImage(named: generalResource.imageName ?? ""))
                    return emptyTableViewCell
                }
            }
        } else if let representable = cellRepresentable as? RepositoryTableViewCellRepresentable {
            let cell = tableView.dequeueReusableCell(withIdentifier: representable.cellReuseIdentifier) as! RepositoryTableViewCell
            cell.delegate = self
            cell.setup(representable: representable, cellIndex: indexPath)
            return cell
        }
        
        return UITableViewCell()
    }

    /// Asks the delegate for the height to use for a row in a specified location.
    ///
    /// - Parameters:
    ///   - tableView: The table view requesting this information.
    ///   - indexPath: An index path that specifies the location of a row in the table view.
    /// - Returns: A value indicating the height of the row in points.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForRow(at: indexPath, tableView: tableView)
    }
    
    /// Tells the delegate that a cell was displayed at a particular row.
    ///
    /// - Parameters:
    ///   - tableView: The table view that displayed the cell.
    ///   - cell: The cell that was displayed.
    ///   - indexPath: The index path of the displayed cell.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard (self.searchController.searchBar.text ?? "").isEmpty else { return }
        guard !self.viewModel.isDataLoading, !self.viewModel.inFavoruiteMode else { return }
        
        if indexPath.row == self.viewModel.representables.count - 3 {
            self.searchForRepositories()
        }
    }
    
    /// Tells the delegate that the specified row is now selected.
    ///
    /// - Parameters:
    ///   - tableView: The table view informing the delegate about the new row selection.
    ///   - indexPath: An index path locating the new selected row in tableView.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let representable = self.viewModel.representableForRow(at: indexPath) as? RepositoryTableViewCellRepresentable {
            let repository = self.viewModel.getRepository(at: indexPath)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let vc = storyboard.instantiateViewController(withIdentifier: "RepositoryDetailViewController") as? RepositoryDetailViewController {
                vc.repository = repository
                vc.isFavorite = representable.isFavorite
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
