//
//  SearchRouter.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit

extension SearchRouter {
    
    private static let _browserSegue = "MVCBrowserViewController"
    
    private static let _loginSegue = "LoginViewController"
}

protocol SearchRoutingLogic {
    
    func routeToBrowser()
    
    func routeToAuth()
    
    func prepareForNextScene(segue: UIStoryboardSegue)
}

protocol SearchDataPassing {
    var dataStore: SearchDataStore? { get }
}

final class SearchRouter: SearchRoutingLogic, SearchDataPassing {
    
    weak var viewController: SearchViewController?
    var dataStore: SearchDataStore?
    
    // MARK: - Routing
    
    func routeToBrowser() {
        viewController?.performSegue(withIdentifier: SearchRouter._browserSegue, sender: nil)
    }
    
    func routeToAuth() {
        viewController?.performSegue(withIdentifier: SearchRouter._loginSegue, sender: nil)
    }
    
    func prepareForNextScene(segue: UIStoryboardSegue) {
        
        switch segue.identifier {
        case SearchRouter._browserSegue?:
            guard let destination = segue.destination as? MVCBrowserViewController,
                let sourceDataStore = dataStore,
                var destinationDataStore = destination.router?.dataStore else { break }
            
            _passDataToBrowser(source: sourceDataStore, destination: &destinationDataStore)
        default:
            break
        }
    }
    
    // MARK: - Passing data
    
    private func _passDataToBrowser(source: SearchDataStore, destination: inout MVCBrowserDataStore) {
        destination.url = source.repoUrl
    }
}
