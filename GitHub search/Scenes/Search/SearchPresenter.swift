//
//  SearchPresenter.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
     func presentRepos(_ response: Search.Repository.Response)
}

final class SearchPresenter: SearchPresentationLogic {

    weak var viewController: SearchDisplayLogic?

    // MARK: - Presentation logic

    func presentRepos(_ response: Search.Repository.Response) {
        
        let repos = response.repos.map { SearchPresenter._repoCellModels(repo: $0) }
        viewController?.updateTableWithModels(.init(repos: repos))
    }
    
}

extension SearchPresenter {
    
    fileprivate static func _repoCellModels(repo: Repo) -> Search.CellModel {
        
        let model = RepoCellModel(name: repo.name,
                                  statusIsHidden: true,
                                  urlString: repo.htmlURLString)
        
        return Search.CellModel(model: model)
    }
}
