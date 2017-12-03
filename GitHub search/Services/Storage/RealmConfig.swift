//
//  RealmConfig.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RealmSwift

enum RealmConfig {
    
    private static let schemaVersion: UInt64 = 1
    
    private static let repositoryConfig = Realm.Configuration.init(fileURL: URL.inDocumentsFolder("repository.realm"),
                                                                  schemaVersion: schemaVersion,
                                                                  deleteRealmIfMigrationNeeded: true,
                                                                  objectTypes: [DBRepo.self])
    
    private static let sessionConfig = Realm.Configuration.init(fileURL: URL.inDocumentsFolder("session.realm"),
                                                                schemaVersion: schemaVersion,
                                                                deleteRealmIfMigrationNeeded: true,
                                                                objectTypes: [UserSession.self])
    
    var configuration: Realm.Configuration {
        switch self {
        case .repository:
            return RealmConfig.repositoryConfig
        case .session:
            return RealmConfig.sessionConfig
        }
    }
    
    case repository
    case session
}
