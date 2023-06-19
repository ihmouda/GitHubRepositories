//
//  RemoteGitHubRepository.swift
//  GitHubRepositories
//
//  Created by mihmouda on 18/06/2023.
//

import Alamofire

/**
 A private enumeration defining the request tags used for the GitHub repository API.
 
 - query: The query parameter key.
 - pageNo: The page number parameter key.
 - limitPerPage: The limit per page parameter key.
 - sort: The sort parameter key.
 - order: The order parameter key.
 */
private enum RepositoryModelRequestTag: String {
    case query = "q"
    case pageNo = "page"
    case limitPerPage = "per_page"
    case sort = "sort"
    case order = "order"
}

/**
 A private enumeration defining the request values used for the GitHub repository API.
 
 - createdAfter: The created date filter value.
 - sortByStars: The sort by stars value.
 - descOrder: The descending order value.
 */
private enum RepositoryModelRequestValue: String {
    case createdAfter = "created:>"
    case sortByStars = "page"
    case descOrder = "desc"
}

/**
 A class representing a remote GitHub repository.
 
 It conforms to the `Repository` protocol and handles the retrieval of GitHub repositories from the remote API.
 */
class RemoteGitHubRepository: Repository {
    typealias T = GitHubRepository
    
    /// The number of repositories to be fetched per page.
    static var limitPerPage = 10
    
    /**
     Retrieves all GitHub repositories based on the specified time frame and page number.
     
     - Parameters:
     - timeFrame: An optional `FilterTimeFrameType` value indicating the time frame for the repositories.
     - pageNo: An optional `Int` value representing the page number for pagination.
     - completion: A closure that will be called when the request is complete, providing a result of type `ModelCompletion<GitHubRepositoryResponse>`.
     */
    func getAll(timeFrame: FilterTimeFrameType?, pageNo: Int?, completion: @escaping ModelCompletion<GitHubRepositoryResponse>) {
        var parameters = Parameters()
        
        let date = timeFrame?.date ?? Date()
        let dateString = DateUtils.getDateStringFrom(date, formatter: "yyyy-MM-dd")
        
        parameters.updateValue(RepositoryModelRequestValue.createdAfter.rawValue + dateString,
                               forKey: RepositoryModelRequestTag.query.rawValue)
        parameters.updateValue(pageNo ?? 0,
                               forKey: RepositoryModelRequestTag.pageNo.rawValue)
        parameters.updateValue(RemoteGitHubRepository.limitPerPage,
                               forKey: RepositoryModelRequestTag.limitPerPage.rawValue)
        parameters.updateValue(RepositoryModelRequestValue.sortByStars.rawValue,
                               forKey: RepositoryModelRequestTag.sort.rawValue)
        parameters.updateValue(RepositoryModelRequestValue.descOrder.rawValue,
                               forKey: RepositoryModelRequestTag.order.rawValue)
        
        NetworkingManager.shared.request(GitHubRepositoryRouter.searchForRepository(parameters: parameters), completionHandler: { (response: ModelResult<GitHubRepositoryResponse>) in
            
            switch response {
                
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error):
                completion(.failure(error: error))
            }
        })
    }
    
    /**
     Retrieves a specific GitHub repository by its ID.
     
     - Parameter id: An `Int` value representing the ID of the repository.
     - Returns: A `GitHubRepository` object if found, or `nil` otherwise.
     */
    func get(_ id: Int) -> GitHubRepository? {
        return nil
    }
    
    /**
     Deletes the specified item from the repository.
     
     - Parameter item: A `GitHubRepository` object to be deleted.
     */
    func delete(_ item: T) {}
    
    
    /**
     Adds the specified item to the repository.
     
     - Parameter item: A `GitHubRepository` object to be added.
     */
    func add(_ item: T) {}
    
}
