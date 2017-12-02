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
    
    func searchRepo(request: Search.Repository.Request)
    
    func verifyUserAuth(request: Search.Auth.Request)
}

protocol SearchDataStore {
    
}

final class SearchInteractor: SearchBusinessLogic, SearchDataStore {

    var presenter: SearchPresentationLogic?
    var worker = SearchWorker()
    
    private let _disposeBag = DisposeBag()

    // MARK: - Business logic

    func searchRepo(request: Search.Repository.Request) {
        worker.loadRepos(request.name)
            .subscribe(onNext: { [weak self] repos in
                self?.presenter?.presentRepos(.init(repos: repos))
            })
            .disposed(by: _disposeBag)
    }
    
    func verifyUserAuth(request: Search.Auth.Request) {
        
    }
}
