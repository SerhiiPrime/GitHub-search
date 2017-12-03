//
//  SearchPresenter.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit

extension SearchPresenter {
    
    fileprivate static let _authTitle = "Auth"
    fileprivate static let _authText = "You need to login first to search repositories"
    fileprivate static let _cancelBtn = "Cancel"
    fileprivate static let _loginBtn = "Login"
}

protocol SearchPresentationLogic {
    
    func presentRepos(_ response: Search.Repository.Response)
    
    func presentBrowser(_ response: Search.SelectRepo.Response)
    
    func presentAuth(_ response: Search.Auth.Response)
}

final class SearchPresenter: SearchPresentationLogic {
    
    weak var viewController: SearchDisplayLogic?
    
    // MARK: - Presentation logic
    
    func presentRepos(_ response: Search.Repository.Response) {
        
        let repos = response.repos.map { SearchPresenter._repoCellModels(repo: $0) }
        viewController?.updateTableWithModels(.init(repos: repos))
    }
    
    func presentBrowser(_ response: Search.SelectRepo.Response) {
        viewController?.displayBrowser(.init())
    }
    
    func presentAuth(_ response: Search.Auth.Response) {
        
        let viewModel = Search.Auth.ViewModel(title: SearchPresenter._authTitle,
                                              text: SearchPresenter._authText,
                                              cancel: SearchPresenter._cancelBtn,
                                              login: SearchPresenter._loginBtn)
        
        viewController?.displayAuthAlert(viewModel)
    }
}

extension SearchPresenter {
    
    fileprivate static func _repoCellModels(repo: DBRepo) -> Search.CellModel {
        
        let model = RepoCellModel(name: repo.name,
                                  statusIsHidden: true,
                                  urlString: repo.htmlURLString)
        
        return Search.CellModel(model: model)
    }
}
