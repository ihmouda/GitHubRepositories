//
//  NetworkingManager+ModelResult.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import Alamofire

/// Model completion block
typealias ModelCompletion<T> = (ModelResult<T>) -> Void

/// Model Result
enum ModelResult<T> {
    case success(T)
    case failure(error: AFError)
    
    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
}
