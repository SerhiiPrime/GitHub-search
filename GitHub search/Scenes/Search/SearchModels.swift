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
            let repos: [Repo]
        }

        struct ViewModel {
            let repos: [Search.CellModel]
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
    
    struct CellModel {
        let model: CellViewAnyModel
    }
}
