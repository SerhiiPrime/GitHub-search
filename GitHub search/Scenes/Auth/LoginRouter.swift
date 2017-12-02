//
//  LoginRouter.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit

protocol LoginRoutingLogic {

    // func routeToNextScene()

    // func prepareForNextScene(segue: UIStoryboardSegue)
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: LoginRoutingLogic,
                                            LoginDataPassing {

    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?

    // MARK: - Routing

    // func routeToNextScene() {
    //     viewController?.performSegue(withIdentifier: "SomeSegueIdentifier", sender: nil)
    // }

    // func prepareForNextScene(segue: UIStoryboardSegue) {

    //     switch segue.identifier {
    //     case "SomeSegueIdentifier"?:
    //         guard let destination = segue.destination as? SomewhereViewController,
    //                 let sourceDataStore = dataStore,
    //                 var destinationDataStore = destination.router?.dataStore else { break }
    
    //             _passDataToAuthWaySMSCode(source: sourceDataStore, destination: &destinationDataStore)
    //     default:
    //         break
    //     }
    // }

    // MARK: - Passing data

    // private func _passDataToSomewhere(source: LoginDataStore,
    //                                   destination: inout SomewhereDataStore) {
    //    destination.name = source.name
    // }
}
