//
//  SearchInteractor.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation

protocol SearchBusinessLogic {
    
    func searchRepo(request: Search.Repo.Request)
    
    func verifyUserAuth(request: Search.Auth.Request)
}

protocol SearchDataStore {
    // var name: String { get set }
}

final class SearchInteractor: SearchBusinessLogic, SearchDataStore {

    var presenter: SearchPresentationLogic?
    var worker: SearchWorker?

    // MARK: - Business logic

    func searchRepo(request: Search.Repo.Request) {
        
    }
    
    func verifyUserAuth(request: Search.Auth.Request) {
        
    }
}
