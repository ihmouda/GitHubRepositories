//
//  RepositoryListViewController.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import UIKit

/// A view controller for displaying a list of repositories.
class RepositoryListViewController: UIViewController {
   
    /// The table view for displaying the repositories.
    @IBOutlet weak var tableView: UITableView!
    
    /// The refresh control for refreshing the repository list.
    private(set) var refreshControl: UIRefreshControl?
    
    /// The view model for managing the repository list.
    private(set) var viewModel: RepositoryListViewModel!
    
    /// The search controller for searching repositories.
    private(set) var searchController = UISearchController(searchResultsController: nil)

    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.viewModel = RepositoryListViewModel()
        self.viewModel.delegate = self
        
        self.setupTableView()
        self.setupRefreshControl()
        self.setupNavigationBar()
        self.setupRightBarButtonItem()
        
        self.addNotifications()
        self.searchForRepositories()
    }
    
    // MARK: Setup methods
    
    /// Sets up the table view.
    private func setupTableView() {
        LoadingTableViewCell.registerCell(inTable: self.tableView)
        EmptyTableViewCell.registerCell(inTable: self.tableView)
    }
    
    /// Sets up the navigation bar.
    private func setupNavigationBar() {
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.showsScopeBar = true
        self.searchController.searchBar.scopeButtonTitles = FilterTimeFrameType.all.map({ $0.title })
        self.searchController.searchBar.backgroundColor = .white
        
        self.navigationItem.searchController = self.searchController

        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    /// Sets up the refresh control.
    private func setupRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self,
                                       action: #selector(refreshSearchForRepositories),
                                       for: .valueChanged)

        self.tableView.refreshControl = self.refreshControl
    }
    
    /// Sets up the right bar button item.
    private func setupRightBarButtonItem() {
        let btnFavourite = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btnFavourite.addTarget(self, action: #selector(favouriteBtnTapped), for: .touchUpInside)
        btnFavourite.setImage(UIImage(systemName: "star.fill"), for: .normal)
        btnFavourite.tintColor = self.viewModel.inFavoruiteMode ? .orange : .gray

        let rightButton = UIBarButtonItem(customView: btnFavourite)
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    /// Handles the tap gesture on the favorite button.
    @objc private func favouriteBtnTapped() {
        
        self.viewModel.setInFavoruiteMode(!self.viewModel.inFavoruiteMode)
        self.searchController.searchBar.showsScopeBar = !self.viewModel.inFavoruiteMode
        self.setupRightBarButtonItem()
        
        self.viewModel.reset()
        
        if self.viewModel.inFavoruiteMode {
            self.viewModel.getRepositoriesUsingRepository(GitHubRepositoryManager(repository: UserDefaultsGitHubRepository()), reloadData: true)
            self.tableView.refreshControl = nil
        } else {
            self.viewModel.getRepositoriesUsingRepository(GitHubRepositoryManager(repository: RemoteGitHubRepository()), reloadData: true)
            self.setupRefreshControl()
        }
        
        self.tableView.reloadData()
    }
    
    /// Refreshes the search for repositories.
    @objc private func refreshSearchForRepositories() {
        if !self.viewModel.isDataLoading {
            self.viewModel.resetRequestStatus()
            self.searchForRepositories()
        }
    }
    
    /// Initiates the search for repositories.
    func searchForRepositories() {
        if !(NetworkingManager.shared.reachabilityManager?.isReachable ?? true) {
            if self.viewModel.handleNoInternetConnection() {
                self.tableView.reloadData()
            } else {
                self.refreshControl?.endRefreshing()
                
                let action = AlertViewUtils.defineOptionAction(title: NSLocalizedString("general.ok", comment: "ok"), style: .cancel, completion: nil)
                
                AlertViewUtils.showAlert(title: nil ,message: NSLocalizedString("error.noInternetConnection", comment: "no internet connection"), actions: [action], viewController: self)
            }
            return
        }
        
        let repository = GitHubRepositoryManager(repository: RemoteGitHubRepository())
        self.viewModel.getRepositoriesUsingRepository(repository, reloadData: true)
    }
    
    /// Notifies the view controller when the scroll view's content offset changes.
    ///
    /// - Parameter scrollView: The scroll view.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navigationItem.searchController = 0.0 < scrollView.contentOffset.y ? nil : self.searchController
    }
}
