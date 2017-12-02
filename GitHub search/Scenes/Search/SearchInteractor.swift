//
//  SearchInteractor.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchBusinessLogic {
    
    func searchRepo(_ request: Search.Repository.Request)
    
    func verifyUserAuth(_ request: Search.Auth.Request)
    
    func didSelectRepo(_ request: Search.SelectRepo.Request)
}

protocol SearchDataStore {
    var repoUrl: URL? { get }
}

final class SearchInteractor: SearchBusinessLogic, SearchDataStore {

    var presenter: SearchPresentationLogic?
    var worker = SearchWorker()
    
    // MARK: - DataStore logic
    
    var repoUrl: URL?
    
    // MARK: - Private properties
    private var repos: [Repo] = []
    private let _disposeBag = DisposeBag()

    // MARK: - Business logic

    func searchRepo(_ request: Search.Repository.Request) {
        worker.loadRepos(request.name)
            .subscribe(onNext: { [weak self] repos in
                self?.repos = repos
                self?.presenter?.presentRepos(.init(repos: repos))
            })
            .disposed(by: _disposeBag)
    }
    
    func verifyUserAuth(_ request: Search.Auth.Request) {
        
    }
    
    func didSelectRepo(_ request: Search.SelectRepo.Request) {
        
        guard let repo = repos[optional: request.index],
            let url = URL(string: repo.htmlURLString) else { return }
        
        repoUrl = url
        presenter?.presentBrowser(.init())
    }
}
