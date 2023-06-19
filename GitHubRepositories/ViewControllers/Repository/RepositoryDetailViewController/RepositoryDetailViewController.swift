//
//  RepositoryDetailViewController.swift
//  GitHubRepositories
//
//  Created by mihmouda on 16/06/2023.
//

import UIKit

class RepositoryDetailViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
    var isFavorite: Bool!
    var repository: GitHubRepository!
    
    private(set) var viewModel: RepositoryDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.viewModel = RepositoryDetailViewModel(repository: self.repository, isFavorite: isFavorite)
        self.setupTableView()
    }
    
    /// Sets up the table view by assigning the delegate and data source, and configuring the row height.
    func setupTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.navigationItem.largeTitleDisplayMode = .never
    }
}

