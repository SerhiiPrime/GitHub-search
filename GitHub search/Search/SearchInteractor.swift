//
//  SearchInteractor.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation

protocol SearchBusinessLogic {
    // func doSomething(request: Search.Something.Request)
}

protocol SearchDataStore {
    // var name: String { get set }
}

final class SearchInteractor: SearchBusinessLogic,
                                                SearchDataStore {

    var presenter: SearchPresentationLogic?
    var worker: SearchWorker?
    // var name: String = ""

    // MARK: - Business logic

    // func doSomething(request: Search.Something.Request) {
    //   worker = SearchWorker()
    //   worker?.doSomeWork()

    //   let response = Search.Something.Response()
    //   presenter?.presentSomething(response: response)
    // }
}
