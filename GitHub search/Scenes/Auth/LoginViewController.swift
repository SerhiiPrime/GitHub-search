//
//  LoginViewController.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit

protocol LoginDisplayLogic: class {
    // func displaySomething(viewModel: Login.Something.ViewModel)
}

final class LoginViewController: UIViewController,
                                                    LoginDisplayLogic {

    @IBOutlet var closeButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    var interactor: LoginBusinessLogic?
    var router: (LoginRoutingLogic & LoginDataPassing)?

    // MARK: - Lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        _setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        _setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Setup

    private func _setup() {
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }

    // MARK: - Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        // router?.prepareForNextScene(segue: segue)
    }

    // MARK: - Display logic

    // func displaySomething(viewModel: Login.Something.ViewModel) {
    //
    // }
}
