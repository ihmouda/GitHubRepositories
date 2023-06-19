//
//  RepositoryModel.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import Alamofire 

class GitHubRepositoryManager<T: Repository> {
   
   /// The underlying repository for managing GitHub repositories.
   var gitHubRepository: T

   /**
    Initializes a new instance of `GitHubRepositoryManager`.
    - Parameter repository: The repository instance conforming to the `Repository` protocol.
    */
   init(repository: T) {
       self.gitHubRepository = repository
   }
}
