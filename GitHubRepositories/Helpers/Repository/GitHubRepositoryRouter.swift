//
//  RepositoryRouter.swift
//  GitHubRepositories
//
//  Created by mihmouda on 15/06/2023.
//

import Alamofire

enum GitHubRepositoryRouter: URLRequestConvertible {
   
   /// Route for searching repositories.
   case searchForRepository(parameters: Parameters)

   /// HTTP method for the route.
   var method: HTTPMethod {
       switch self {
       case .searchForRepository(_):
           return .get
       }
   }
   
   /// Path component for the route.
   var path: String {
       switch self {
       case .searchForRepository(_):
           return "/search/repositories"
       }
   }
   
   /// Base URL string for the API.
   var baseUrlString: String {
       let baseURL = ConfigurationManager.shared.configuration?.apiBaseUrl ?? ""
       return baseURL
   }
   
   /**
    Converts the route to a URLRequest.
    
    - Returns: The URLRequest representing the route.
    - Throws: An error if the conversion fails.
    */
   func asURLRequest() throws -> URLRequest {
       
       let url = try self.baseUrlString.asURL()
       
       var urlRequest = URLRequest(url: url.appendingPathComponent(self.path))
       urlRequest.httpMethod = self.method.rawValue
       
       switch self {
       case .searchForRepository(let parameters):
           urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
       }
       
       return urlRequest
   }
}

