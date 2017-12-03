//
//  DBRepo.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/3/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RealmSwift

class DBRepo: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var htmlURLString = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension DBRepo {
    
    static func dbRepoFrom(_ repo: Repo) -> DBRepo {
        
        let dbRepo = DBRepo()
        dbRepo.id = repo.id
        dbRepo.name = repo.name
        dbRepo.htmlURLString = repo.htmlURLString
        return dbRepo
    }
}
