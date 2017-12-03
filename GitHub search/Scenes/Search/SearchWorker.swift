//
//  SearchWorker.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

final class SearchWorker {

    private let _networkService: NetworkServiceProtocol
    private let _reposDBService: ReposDBServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared,
         reposDBService: ReposDBServiceProtocol = ReposDBService.shared) {
        _networkService = networkService
        _reposDBService = reposDBService
    }
    
    func loadRepos(_ query: String) -> Observable<[Repo]> {        
        return _networkService.getRepos(query)
    }
    
    func getAllRepos() -> Results<DBRepo> {
        return _reposDBService.getAllRepos()
    }
    
    func saveRepos(repos: [Repo]) {
        
        let dbRepos = repos.flatMap(DBRepo.dbRepoFrom)
        _reposDBService.saveRepos(dbRepos)
    }
    
    func markRepoViewed(_ repo: DBRepo) {
        _reposDBService.markRepoViewed(repo)
    }
}
