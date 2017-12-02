//
//  SearchRouter.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit

protocol SearchRoutingLogic {

    // func routeToNextScene()

    // func prepareForNextScene(segue: UIStoryboardSegue)
}

protocol SearchDataPassing {
    var dataStore: SearchDataStore? { get }
}

final class SearchRouter: SearchRoutingLogic,
                                            SearchDataPassing {

    weak var viewController: SearchViewController?
    var dataStore: SearchDataStore?

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

    // private func _passDataToSomewhere(source: SearchDataStore,
    //                                   destination: inout SomewhereDataStore) {
    //    destination.name = source.name
    // }
}
