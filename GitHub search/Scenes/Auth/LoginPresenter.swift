//
//  LoginPresenter.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit

protocol LoginPresentationLogic {
    // func presentSomething(response: Login.Something.Response)
}

final class LoginPresenter: LoginPresentationLogic {

    weak var viewController: LoginDisplayLogic?

    // MARK: - Presentation logic

    // func presentSomething(response: Login.Something.Response) {
    //   let viewModel = Login.Something.ViewModel()
    //   viewController?.displaySomething(viewModel: viewModel)
    // }
}
