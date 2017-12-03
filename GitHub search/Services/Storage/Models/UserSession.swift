//
//  UserSession.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RealmSwift

class UserSession: Object {
    
    @objc dynamic var userId: String = ""
    @objc dynamic var userName: String = ""

    override class func primaryKey() -> String? {
        return "userId"
    }
}
