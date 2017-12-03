//
//  SearchModels.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit

enum Search {
    
    enum Repository {

        struct Request {
            let name: String
        }

        struct Response {
            let repos: [DBRepo]
        }

        struct ViewModel {
            let repos: [Search.CellModel]
        }
    }
    
    enum TableUpdates {
        
        struct Request {}
        
        struct Response {
            let repos: [DBRepo]
            let insertions: [Int]
            let deletions: [Int]
            let modifications: [Int]
        }
        
        struct ViewModel {
            let repos: [Search.CellModel]
            let insertions: [IndexPath]
            let deletions: [IndexPath]
            let modifications: [IndexPath]
        }
    }
    
    enum Auth {
        
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {
            let title: String
            let text: String
            let cancel: String
            let login: String
        }
    }
    
    enum SelectRepo {
        
        struct Request {
            let index: Int
        }
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum DeleteRepo {
        
        struct Request {
            let index: Int
        }
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    struct CellModel {
        let model: CellViewAnyModel
    }
}
