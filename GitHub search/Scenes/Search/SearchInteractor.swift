//
//  SearchInteractor.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

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
    var worker: SearchWorker!
    
    // MARK: - DataStore logic
    
    var repoUrl: URL?
    
    // MARK: - Private properties
    private let _disposeBag = DisposeBag()
    
    private var reposSubscription: NotificationToken?
    private var reposResults: Results<DBRepo>!
    private var repos: [DBRepo] = []
    
    
    init() {
        worker = SearchWorker()
        reposResults = worker.getAllRepos()
        reposSubscription = notificationSubscription(result: reposResults)
    }

    // MARK: - Business logic

    func searchRepo(_ request: Search.Repository.Request) {
        worker.loadRepos(request.name)
            .subscribe(onNext: { [weak self] repos in
                self?.worker.saveRepos(repos: repos)
            })
            .disposed(by: _disposeBag)
    }
    
    func verifyUserAuth(_ request: Search.Auth.Request) {
        //presenter?.presentAuth(.init())
    }
    
    func didSelectRepo(_ request: Search.SelectRepo.Request) {
        
        guard let repo = repos[optional: request.index],
            let url = URL(string: repo.htmlURLString) else { return }
        
        repoUrl = url
        presenter?.presentBrowser(.init())
    }
    
    
    // MARK: - Notification subscription
    //
    func notificationSubscription(result: Results<DBRepo>) -> NotificationToken {
        return result.addNotificationBlock {[weak self] (changes: RealmCollectionChange<Results<DBRepo>>) in
            guard let `self` = self else { return }
        
            self.repos = Array(self.reposResults).sorted{ $0.starsCount > $1.starsCount }
            self.presenter?.presentRepos(.init(repos: self.repos))
        }
    }
}
