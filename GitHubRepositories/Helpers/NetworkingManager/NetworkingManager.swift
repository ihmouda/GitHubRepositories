//
//  NetworkingManager.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import Alamofire

/**
 Represents the status of a network request.
 
 The `RequestStatus` enum defines different statuses that can be associated with a network request.
 
 - `loading`: The request is in progress.
 - `failed`: The request has failed.
 - `success`: The request was successful.
 */
enum RequestStatus {
    case loading
    case failed
    case success
}

/**
 A manager class responsible for handling network requests using Alamofire.
 
 The `NetworkingManager` class provides a centralized way to perform network requests and handle their responses.
 */
final class NetworkingManager {
  
    /// The singleton instance of the `NetworkingManager`.
    static let shared = NetworkingManager()
    
    /// The network reachability manager for monitoring the network status.
    let reachabilityManager: NetworkReachabilityManager? = {
        
        guard let urlString = ConfigurationManager.shared.configuration?.apiBaseUrl,
              let url = URL(string: urlString),
              let host = url.host
        else { return nil }
        
        return Alamofire.NetworkReachabilityManager(host: host)
    }()
    
    /**
     Sends a network request and handles the response.
     
     This method sends a network request using Alamofire's `AF.request` and handles the response by decoding it into the specified type. The result is then passed to the completion handler.
     
     - Parameters:
        - convertible: The request convertible object that represents the URL request.
        - completionHandler: The closure to be called when the request is complete. It receives a result of type `ModelCompletion` that encapsulates the success or failure of the request.
     */
    func request<T>(_ convertible: URLRequestConvertible, completionHandler: @escaping ModelCompletion<T>) where T: Decodable {

        AF.request(convertible).responseDecodable(of: T.self) { response in
            
            switch response.result {
                
            case .success(let data):
                completionHandler(.success(data))
                
            case .failure(let error):
                completionHandler(.failure(error: error))
            }
        }
    }
}
