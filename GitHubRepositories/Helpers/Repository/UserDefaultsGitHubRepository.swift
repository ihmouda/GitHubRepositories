//
//  UserDefaultsGitHubRepository.swift
//  GitHubRepositories
//
//  Created by mihmouda on 18/06/2023.
//

import Foundation

/**
 A repository class for managing GitHub repositories using UserDefaults as the storage mechanism.
 
 This class conforms to the `Repository` protocol and provides methods for adding, retrieving, and deleting GitHub repositories from UserDefaults.
 */
class UserDefaultsGitHubRepository: Repository {
    
    typealias T = GitHubRepository

    /**
     Adds a GitHub repository to the favorites list in UserDefaults.
     
     - Parameter item: The GitHub repository to be added.
     */
    func add(_ item: T) {
        self.getAll { result in
            switch result {
            case .success(let data):
                var storedFavoriteList = data.items
                storedFavoriteList.append(item)

                if let encoded = try? JSONEncoder().encode(storedFavoriteList){
                    UserDefaultUtils.setObjectValue(encoded, forKey: .favoriteList)
                }
                
            case .failure(_):
                break
            }
        }
    }

    /**
     Retrieves all GitHub repositories from the favorites list in UserDefaults.
     
     - Parameters:
        - timeFrame: Optional. The time frame for filtering the repositories.
        - pageNo: Optional. The page number for pagination.
        - completion: A closure to be called when the retrieval is completed. It returns a `GitHubRepositoryResponse` object or an error.
     */
    func getAll(timeFrame: FilterTimeFrameType? = nil, pageNo: Int? = nil, completion: @escaping ModelCompletion<GitHubRepositoryResponse>) {
        
        if let dataList = UserDefaultUtils.getObjectValueForKey(.favoriteList) as? Data,
           let list = try? JSONDecoder().decode(Array.self, from: dataList) as [GitHubRepository] {
            
            return completion(.success(GitHubRepositoryResponse(totalCount: list.count, items: list)))
        }
        
        completion(.success(GitHubRepositoryResponse(totalCount: 0, items: [])))
    }

    /**
     Deletes a GitHub repository from the favorites list in UserDefaults.
     
     - Parameter item: The GitHub repository to be deleted.
     */
    func delete(_ item: T) {
        self.getAll { result in
            
            switch result {
                
            case .success(let data):
                
                var storedFavoriteList = data.items
                if let index = storedFavoriteList.firstIndex(of: item) {
                    storedFavoriteList.remove(at: index)
                    
                    if let encoded = try? JSONEncoder().encode(storedFavoriteList){
                        UserDefaultUtils.setObjectValue(encoded, forKey: .favoriteList)
                    }
                }
                
            case .failure(_):
                break
            }
        }
    }
}

