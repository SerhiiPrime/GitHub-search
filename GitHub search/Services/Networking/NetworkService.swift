//
//  GitHubService.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol NetworkServiceProtocol: class {
    
    func getRepos(_ query: String) -> Observable<[Repo]>
}

class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    
    private let networkManager: SessionManager!
    
    private init() {
        networkManager = Alamofire.SessionManager.default
    }

    func getRepos(_ query: String) -> Observable<[Repo]> {
        
       
    }
}
