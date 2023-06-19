//
//  RepositoryListViewModel.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import UIKit

/// The view model for the repository list screen.
class RepositoryListViewModel {
    
    // MARK: - Properties
    
    // Array of all repositories
    private(set) var repositories: [GitHubRepository] = []
    
    // Array of favourite repositories
    var favouriteRepositories: [GitHubRepository] = []
    
    // Array of repositories after filtering
    private(set) var filteredRepositories: [GitHubRepository] = []
    
    // Array of table view cell representables
    private(set) var representables: [TableViewCellRepresentable] = []
    
    // Current page number for pagination
    private(set) var pageNo: Int = 0
    
    // Text used for filtering repositories
    private(set) var searchText: String? = nil
    
    // Flag indicating whether to show only favourite repositories
    private(set) var inFavoruiteMode: Bool = false
    
    // Selected time frame for filtering
    private(set) var selectedTimeFrame: FilterTimeFrameType = .lastDay
    
    // Status of the data request
    private var requestStatus: RequestStatus = .loading
    
    // Delegate to communicate with the view
    weak var delegate: RepositoryListViewModelProtocol?
    
    var isDataLoading: Bool {
        return self.requestStatus == RequestStatus.loading
    }
    
    var isDataRequestFailed: Bool {
        return self.requestStatus == RequestStatus.failed
    }
    
    // MARK: - Initialization
    
    init() {
        
        // Initialize representables with a loading resource
        let generalResource = GeneralResource(imageName: nil, type: GeneralResourceType.loading)
        self.representables = [GeneralResourceTableViewCellRepresentable(generalResource: generalResource)]
        
        self.getRepositoriesUsingRepository(GitHubRepositoryManager(repository: UserDefaultsGitHubRepository()))
    }
    
    // MARK: - Public Methods
    
    /// Reset the view model to its initial state.
    func reset() {
        self.pageNo = 0
        
        // Reset representables with a loading resource
        let generalResource = GeneralResource(imageName: nil, type: GeneralResourceType.loading)
        self.representables = [GeneralResourceTableViewCellRepresentable(generalResource: generalResource)]
        
        // Clear repositories and filtered repositories
        self.repositories = []
        self.filteredRepositories = []
        
        // Load favourite repositories
        self.getRepositoriesUsingRepository(GitHubRepositoryManager(repository: UserDefaultsGitHubRepository()))
        
        // Reset request status to loading
        self.requestStatus = RequestStatus.loading
    }
    
    /// Set the selected time frame for filtering repositories.
    /// - Parameter timeFrame: The selected time frame.
    func setSelectedTimeFrame(_ timeFrame: FilterTimeFrameType) {
        self.selectedTimeFrame = timeFrame
    }
    
    /// Set the search text for filtering repositories.
    /// - Parameter searchText: The search text.
    func setSearchText(_ searchText: String) {
        self.searchText = searchText
        
        // Filter repositories and update representables
        self.filterRepositories()
        self.buildRepresentables()
    }
    
    /// Set the favourite mode for showing only favourite repositories.
    /// - Parameter inFavoruiteMode: The favourite mode flag.
    func setInFavoruiteMode(_ inFavoruiteMode: Bool) {
        self.inFavoruiteMode = inFavoruiteMode
    }
    
    /// Reset the request status to loading.
    func resetRequestStatus() {
        self.requestStatus = RequestStatus.loading
    }
    
    /// Set the repositories and update the view.
    /// - Parameters:
    ///   - repositories: The new repositories.
    ///   - hasMoreData: Flag indicating if there is more data available for pagination.
    func setRepositories(_ repositories: [GitHubRepository], hasMoreData: Bool, reloadData: Bool = false) {
        
        if !self.inFavoruiteMode && reloadData {
            
            self.pageNo += 1
            self.repositories.append(contentsOf: repositories)
            self.filteredRepositories = self.repositories
        } else if self.inFavoruiteMode {
            self.filteredRepositories = repositories
        } else {
            self.favouriteRepositories = repositories
        }

        guard reloadData
        else { return }
        
        self.requestStatus = RequestStatus.success
        // Build representables for the updated repositories
        self.buildRepresentables()
        
        // Add loading representable if there is more data
        if hasMoreData {
            self.representables.append(self.getLoadingRepresentable())
        }
    }
    
    // MARK: - Private Methods
    
    /// Filter repositories based on search text and favourite mode.
    func filterRepositories() {
        let data = self.inFavoruiteMode ? self.favouriteRepositories : self.repositories
        
        if let searchText = self.searchText, !searchText.isEmpty {
            self.filteredRepositories = data.filter({ $0.name.lowercased().contains(searchText.lowercased())})
        } else {
            self.filteredRepositories = data
        }
    }
    
    /// Build representables based on filtered repositories.
    func buildRepresentables() {
        // Remove all items from representables
        self.representables.removeAll()
        
        for (index, repository) in filteredRepositories.enumerated() {
            let isFavorite = self.favouriteRepositories.contains(repository)
            let representable = RepositoryTableViewCellRepresentable(repository: repository, indexPath: IndexPath(row: 0, section: index), isFavorite: isFavorite)
            self.representables.append(representable)
        }
        
        // Add empty state representable if there are no repositories
        if self.representables.isEmpty {
            let generalResource = GeneralResource(imageName: "empty_state", type: .empty)
            self.representables.append(GeneralResourceTableViewCellRepresentable(generalResource: generalResource))
        }
    }
    
    /// Get the loading representable.
    /// - Returns: The loading representable.
    private func getLoadingRepresentable() -> TableViewCellRepresentable {
        let generalResource = GeneralResource(imageName: nil, type: GeneralResourceType.loading)
        let tableViewCellRepresentable = GeneralResourceTableViewCellRepresentable(generalResource: generalResource)
        return tableViewCellRepresentable
    }
    
    // MARK: - Table View Methods
    
    /// Get the number of sections in the table view.
    /// - Returns: The number of sections.
    func numberOfSections() -> Int {
        return 1
    }

    /// Get the number of rows in the specified section of the table view.
    /// - Parameter section: The section index.
    /// - Returns: The number of rows in the section.
    func numberOfRows(inSection section: Int) -> Int {
        return self.representables.count
    }

    /// Get the height for the row at the specified index path in the table view.
    /// - Parameters:
    ///   - indexPath: The index path of the row.
    ///   - tableView: The table view.
    /// - Returns: The height for the row.
    func heightForRow(at indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        if let cellRepresentable = self.representableForRow(at: indexPath) {
            if let generalRepresentable = cellRepresentable as? GeneralResourceTableViewCellRepresentable {
                if generalRepresentable.type == GeneralResourceType.loading {
                    if self.representables.count == 1 {
                        return LoadingTableViewCell.getCellHeight(forTableView: tableView)
                    } else {
                        return 100.0
                    }
                } else {
                    return EmptyTableViewCell.getCellHeight(forTableView: tableView)
                }
            } else {
                return UITableView.automaticDimension
            }
        }
        return 0
    }

    /// Get the representable for the row at the specified index path.
    /// - Parameter indexPath: The index path of the row.
    /// - Returns: The representable for the row.
    func representableForRow(at indexPath: IndexPath) -> TableViewCellRepresentable? {
        return self.representables[indexPath.row]
    }
    
    /// Get the GitHub repository at the specified index path.
    /// - Parameter indexPath: The index path of the repository.
    /// - Returns: The GitHub repository.
    func getRepository(at indexPath: IndexPath) -> GitHubRepository {
        return self.filteredRepositories[indexPath.row]
    }
    
    // MARK: - Error Handling Methods
    
    /// Handle the case of no internet connection.
    /// - Returns: A boolean value indicating if the handling was successful.
    func handleNoInternetConnection() -> Bool {
        // Check if request is loading and set it as failed
        if self.requestStatus == RequestStatus.loading {
            self.requestStatus = RequestStatus.failed
        }
        
        // Create general resource for network error
        let generalResource = GeneralResource(imageName: "network_error", type: .networkError)
        let noInternetRepresentables = [GeneralResourceTableViewCellRepresentable(generalResource: generalResource)]
        
        if self.representables.isEmpty || self.representableForRow(at: IndexPath(row: 0, section: 0)) is GeneralResourceTableViewCellRepresentable {
            if let generalRepresentable = self.representableForRow(at: IndexPath(row: 0, section: 0)) as? GeneralResourceTableViewCellRepresentable, !(generalRepresentable.type == GeneralResourceType.loading || generalRepresentable.type == GeneralResourceType.networkError) {
                return false
            }
            
            // Update representables with no internet connection resources
            self.representables = noInternetRepresentables
            return true
        }
        
        return false
    }
    
    /// Handle the case of failed repository retrieval.
    /// - Returns: A boolean value indicating if the handling was successful.
    func handleFailedToGetRepositories() -> Bool {
        // Set request status as failed
        self.requestStatus = RequestStatus.failed
        
        // Check if first representable is General Resource
        if self.representables.isEmpty || self.representableForRow(at: IndexPath(row: 0, section: 0)) is GeneralResourceTableViewCellRepresentable {
            // Create general resource for failed request
            let generalResource = GeneralResource(imageName: "failed_request", type: GeneralResourceType.empty)
            self.representables = [GeneralResourceTableViewCellRepresentable(generalResource: generalResource)]
            return true
        }
        return false
    }
}

