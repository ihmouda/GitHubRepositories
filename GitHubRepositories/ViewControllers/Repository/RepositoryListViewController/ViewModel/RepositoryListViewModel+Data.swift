//
//  RepositoryListViewModel+Network.swift
//  GitHubRepositories
//
//  Created by mihmouda on 18/06/2023.
//

import Alamofire

extension RepositoryListViewModel {
    
    /**
      Fetches the repositories using the specified repository manager.
      
      - Parameters:
         - repository: The repository manager conforming to `GitHubRepositoryManager` and `Repository`.
      */
    func getRepositoriesUsingRepository<T: GitHubRepositoryManager<G>, G: Repository>(_ repository: T, reloadData: Bool = false) {
         
         self.resetRequestStatus()
         
         // Get data
         repository.gitHubRepository.getAll(timeFrame: self.selectedTimeFrame, pageNo: self.pageNo + 1) { [weak self] result in
             // Get strong self reference
             guard let strongSelf = self else { return }
             
             switch result {
             case .success(let data):
                 strongSelf.didGetRepositoriesData(data, reloadData: reloadData)
                 break
                 
             case .failure(let error):
                 strongSelf.failedToGetRepositoriesData(error)
                 break
             }
         }
     }
     
     /**
      Handles the successful retrieval of repository data.
      
      - Parameter result: The `GitHubRepositoryResponse` object containing the fetched repositories.
      */
     private func didGetRepositoriesData(_ result: GitHubRepositoryResponse, reloadData: Bool = false) {
         let itemsCount = (self.repositories.count + result.items.count)
         let hasMoreData = itemsCount < result.totalCount
         
         self.setRepositories(result.items, hasMoreData: hasMoreData, reloadData: reloadData)
         self.delegate?.reloadTableView()
     }
     
     /**
      Handles the failure to retrieve repository data.
      
      - Parameter error: The `AFError` object indicating the failure.
      */
     private func failedToGetRepositoriesData(_ error: AFError) {
         if !(NetworkingManager.shared.reachabilityManager?.isReachable ?? true) {
             return
         }
         
         // Handle Failed Get
         if !self.handleFailedToGetRepositories() {
             self.delegate?.showFailedAlertView()
         }
         
         // Reload data
         self.delegate?.reloadTableView()
     }
     
     /**
      Adds a repository to the favorite repositories using the specified repository manager.
      
      - Parameters:
         - repository: The repository manager conforming to `GitHubRepositoryManager` and `Repository`.
         - repo: The `GitHubRepository` object to be added.
      */
     func favoriteRepositoryUsingRepository<T: GitHubRepositoryManager<G>, G: Repository>(_ repository: T, repo: GitHubRepository) {
         repository.gitHubRepository.add(repo as! G.T)
         
         repository.gitHubRepository.getAll(timeFrame: nil, pageNo: nil) { result in
             switch result {
             case .success(let data):
                 
                 self.favouriteRepositories = data.items
                 self.filterRepositories()
                 self.buildRepresentables()
                 break

             case .failure(_):
                 break
             }
         }
     }
     
     /**
      Removes a repository from the favorite repositories using the specified repository manager.
      
      - Parameters:
         - repository: The repository manager conforming to `GitHubRepositoryManager` and `Repository`.
         - repo: The `GitHubRepository` object to be removed.
      */
     func unFavoriteRepositoryUsingRepository<T: GitHubRepositoryManager<G>, G: Repository>(_ repository: T, repo: GitHubRepository) {
         repository.gitHubRepository.delete(repo as! G.T)
         
         repository.gitHubRepository.getAll(timeFrame: nil, pageNo: nil) { result in
             switch result {
             case .success(let data):
                 
                 self.favouriteRepositories = data.items
                 self.filterRepositories()
                 self.buildRepresentables()
                 break

             case .failure(_):
                 break
             }
         }
     }
 }
