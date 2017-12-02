//
//  Request.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    
    public func logRequest() -> Self {
        debugPrint(self)
        return self
    }
}
