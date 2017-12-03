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
    
    func saveRepos(repos: [DBRepo])
}

class ReposDBService: ReposDBServiceProtocol {
    
    static let shared = ReposDBService()
    
    private let realm: Realm!
    
    private init() {
        realm = try! Realm(configuration: RealmConfig.repository.configuration)
    }
    
    func getAllRepos() -> Results<DBRepo> {
        return realm.objects(DBRepo.self)
    }
    
    func saveRepos(repos: [DBRepo]) {
        
        // We want to have only repos from last search query
        try! realm.write {
            realm.deleteAll()
        }
        
        try! realm.write {
            realm.add(repos)
        }
    }
}
