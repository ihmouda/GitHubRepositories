//
//  Repository.swift
//  GitHubRepositories
//
//  Created by mihmouda on 18/06/2023.
//

import Foundation

protocol Repository {
   associatedtype T
   
   /**
    Adds an item to the repository.
    
    - Parameter item: The item to be added.
    */
   func add(_ item: T)
   
   /**
    Deletes an item from the repository.
    
    - Parameter item: The item to be deleted.
    */
   func delete(_ item: T)
   
   /**
    Retrieves all items from the repository.
    
    - Parameters:
       - timeFrame: Optional. The time frame for filtering the items.
       - pageNo: Optional. The page number for pagination.
       - completion: A closure to be called when the retrieval is completed. It returns a `GitHubRepositoryResponse` object or an error.
    */
   func getAll(timeFrame: FilterTimeFrameType?, pageNo: Int?, completion: @escaping ModelCompletion<GitHubRepositoryResponse>)
}

