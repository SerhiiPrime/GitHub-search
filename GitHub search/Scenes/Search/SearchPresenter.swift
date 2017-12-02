//
//  SearchPresenter.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
    // func presentSomething(response: Search.Something.Response)
}

final class SearchPresenter: SearchPresentationLogic {

    weak var viewController: SearchDisplayLogic?

    // MARK: - Presentation logic

    // func presentSomething(response: Search.Something.Response) {
    //   let viewModel = Search.Something.ViewModel()
    //   viewController?.displaySomething(viewModel: viewModel)
    // }
}
