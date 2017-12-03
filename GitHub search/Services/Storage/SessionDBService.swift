//
//  SessionDBService.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/3/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RealmSwift

protocol SessionDBServiceProtocol: class {

}

class SessionDBService: SessionDBServiceProtocol {
    
    private let realmMessenger: Realm!
    
    init() {
        realmMessenger = try! Realm(configuration: RealmConfig.session.configuration)
    }
    
}
