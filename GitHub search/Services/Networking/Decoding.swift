//
//  Decoding.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation

struct Decoding {
    
    public static func decode<T: Decodable>(_ type: T.Type,
                                            topLevelKey: String? = nil,
                                            from data: Data) throws -> T {
        
        let decoder = JSONDecoder()
        
        return try decoder.decodeWrappedObject(type: type,
                                               topLevelKey: topLevelKey,
                                               from: data)
    }
}
