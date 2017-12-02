//
//  JSONDecoder.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation

private let userInfoKey = CodingUserInfoKey(rawValue: "com.gitHub_search")!

private struct _CodingKey: CodingKey {
    
    let key: String
    
    var stringValue: String { return key }
    
    var intValue: Int? { return nil }
    
    init(stringValue: String) { key = stringValue }
    
    init?(intValue: Int) { return nil }
}

private struct DecodableWrapper<T: Decodable>: Decodable {
    
    let wrapped: T
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: _CodingKey.self)
        
        guard let key = decoder.userInfo[userInfoKey] as? String else {
            assertionFailure("The top-level key is not set")
            let context = DecodingError.Context(codingPath: [], debugDescription: "The top-level key is not set")
            throw DecodingError.dataCorrupted(context)
        }
        
        wrapped = try container.decode(T.self, forKey: _CodingKey(stringValue: key))
    }
}

extension JSONDecoder {
    
    /// Assume we have the following JSON:
    ///
    /// ```
    /// {
    ///    "ObjectType": {
    ///        "key": "value"
    ///    }
    /// }
    /// ```
    ///
    /// By invoking this methods as `decoder.decodeWrappedObject(type: ObjectType.self)`
    /// we can get the decodable.
    ///
    /// - Parameters:
    ///   - type: The type that is encoded in JSON
    ///           with a single key of the same name as the type.
    ///   - topLevelKey: The top-level key that wraps a value of type `T`.
    ///                  If `nil`, uses the type name. Defaults to `nil`
    ///   - data: The data to decode from.
    /// - Returns: A value of the requested type.
    /// - Throws: An error if any value throws an error during decoding.
    func decodeWrappedObject<T: Decodable>(type: T.Type,
                                           topLevelKey: String? = nil,
                                           from data: Data) throws -> T {
        
        let typeName = topLevelKey ?? String(describing: type)
        
        func _keyNotFoundError() -> Error {
            
            let context = DecodingError
                .Context(codingPath: [],
                         debugDescription: "The top-level dictionary doesn't contain a key named \(typeName)")
            
            return DecodingError.keyNotFound(_CodingKey(stringValue: typeName), context)
        }
        
        if topLevelKey == nil {
            do {
                return try decode(T.self, from: data)
            } catch {
                // Continue, try to decode as a wrapped object
            }
        }
        
        // This value will be extracted by the `DecodableWrapper`.
        userInfo[userInfoKey] = typeName
        
        do {
            
            let wrapper = try decode(DecodableWrapper<T>.self, from: data)
            return wrapper.wrapped
            
        } catch DecodingError.typeMismatch {
            
            let wrapper = try decode(DecodableWrapper<[T]>.self, from: data)
            
            if let value = wrapper.wrapped.first {
                return value
            } else {
                
                let context = DecodingError
                    .Context(codingPath: [_CodingKey(stringValue: typeName)],
                             debugDescription: "The value for key \(typeName) contains an empty array ")
                
                throw DecodingError.valueNotFound(T.self, context)
            }
            
        } catch {
            
            throw error
        }
    }
}
