//
//  Repo.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation

struct Repo: Decodable {
    
    let id: Int
    
    let name: String
    
    let htmlURLString: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case htmlURLString = "html_url"
    }
}

