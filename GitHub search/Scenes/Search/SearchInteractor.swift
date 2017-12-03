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
    
    func didDeleteRepo(_ request: Search.DeleteRepo.Request)
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
        
        //TODO: - Check User Auth
        //presenter?.presentAuth(.init())
    }
    
    func didSelectRepo(_ request: Search.SelectRepo.Request) {
        
        guard let repo = repos[optional: request.index],
            let url = URL(string: repo.htmlURLString) else { return }
        
        repoUrl = url
        presenter?.presentBrowser(.init())
        
        // Mark repository as viewed
        worker.markRepoViewed(repo)
    }
    
    func didDeleteRepo(_ request: Search.DeleteRepo.Request) {

        guard let repo = repos[optional: request.index] else { return }
        worker.deleteRepo(repo)
    }
    
    
    // MARK: - Notification subscription
    //
    func notificationSubscription(result: Results<DBRepo>) -> NotificationToken {
        return result.addNotificationBlock {[weak self] (changes: RealmCollectionChange<Results<DBRepo>>) in
            guard let `self` = self else { return }
            
            self.repos = Array(self.reposResults)
            
            switch changes {
            case .initial:

                self.presenter?.setupTable(.init(repos: self.repos))
                
            case .update(_, let deletions, let insertions, let modifications):
                
                let response = Search.TableUpdates.Response(repos: self.repos,
                                                            insertions: insertions,
                                                            deletions: deletions,
                                                            modifications: modifications)
                
                self.presenter?.updateTable(response)
                
            default:
                break
            }
        }
    }
}
