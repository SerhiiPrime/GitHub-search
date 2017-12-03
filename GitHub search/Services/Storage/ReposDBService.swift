//
//  DBService.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/3/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RealmSwift

protocol ReposDBServiceProtocol: class {
    
    func getAllRepos() -> Results<DBRepo>
    
    func saveRepos(_ repos: [DBRepo])
    
    func markRepoViewed(_ repo: DBRepo)
    
    func deleteRepo(_ repo: DBRepo)
}

class ReposDBService: ReposDBServiceProtocol {
    
    private let realm: Realm!
    
    init() {
        realm = try! Realm(configuration: RealmConfig.repository.configuration)
    }
    
    func getAllRepos() -> Results<DBRepo> {
        return realm.objects(DBRepo.self)
    }
    
    func saveRepos(_ repos: [DBRepo]) {
        
        // We want to have only repos from last search query
        try! realm.write {
            realm.deleteAll()
        }
        
        try! realm.write {
            realm.add(repos)
        }
    }
    
    func markRepoViewed(_ repo: DBRepo) {
        
        try! realm.write {
            repo.isViewed = true
            realm.add(repo, update: true)
        }
    }
    
    func deleteRepo(_ repo: DBRepo) {
        try! realm.write {
            realm.delete(repo)
        }
    }
}
