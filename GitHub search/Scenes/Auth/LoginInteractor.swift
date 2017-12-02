//
//  LoginInteractor.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation

protocol LoginBusinessLogic {
    // func doSomething(request: Login.Something.Request)
}

protocol LoginDataStore {
    // var name: String { get set }
}

final class LoginInteractor: LoginBusinessLogic,
                                                LoginDataStore {

    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
    // var name: String = ""

    // MARK: - Business logic

    // func doSomething(request: Login.Something.Request) {
    //   worker = LoginWorker()
    //   worker?.doSomeWork()

    //   let response = Login.Something.Response()
    //   presenter?.presentSomething(response: response)
    // }
}
