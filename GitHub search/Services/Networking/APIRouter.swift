//
//  APIRouter.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    private enum Constants {
        static let baseURL = "https://api.github.com/"
    }
    
    case getRepos(query: String)
    
    var method: HTTPMethod{
        switch self {
            
        case .getRepos:
            return .get
        }
    }
    
    var path: String {
        switch self {
            
        case .getRepos(let query):
            return "search/repositories?q=\(query)"
        }
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        switch self {
            
        case .getRepos:
            return URLEncoding.default
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}
