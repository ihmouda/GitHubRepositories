//
//  RepositoryDetailViewController+TableView.swift
//  GitHubRepositories
//
//  Created by mihmouda on 16/06/2023.
//

import UIKit

/**
 Extension of `RepositoryDetailViewController` implementing `UITableViewDataSource` and `UITableViewDelegate`.
 
 This extension adds conformance to the `UITableViewDataSource` and `UITableViewDelegate` protocols for the `RepositoryDetailViewController` class. It provides the necessary methods to populate and configure the table view in the repository detail view controller.
 */
extension RepositoryDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    /**
     Returns the number of sections in the table view.
     
     - Parameter tableView: The table view requesting this information.
     - Returns: The number of sections in the table view.
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections()
    }

    /**
     Returns the number of rows in the specified section of the table view.
     
     - Parameters:
        - tableView: The table view requesting this information.
        - section: The index of the section.
     - Returns: The number of rows in the specified section of the table view.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows(inSection: section)
    }

    /**
     Returns a configured cell for the specified index path.
     
     - Parameters:
        - tableView: The table view requesting this cell.
        - indexPath: The index path that specifies the location of the cell.
     - Returns: A configured cell for the specified index path.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get cell Representable
        let cellRepresentable = self.viewModel.representableForRow(at: indexPath)
         
        if let representable = cellRepresentable as? RepositoryTableViewCellRepresentable {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: representable.cellReuseIdentifier) as! RepositoryTableViewCell
            
            cell.setup(representable: representable, cellIndex: indexPath)
            return cell
        }
        
        return UITableViewCell()
    }

    /**
     Returns the height for the specified row.
     
     - Parameters:
        - tableView: The table view requesting this information.
        - indexPath: The index path of the row.
     - Returns: The height for the specified row.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForRow(at: indexPath, tableView: tableView)
    }
}
