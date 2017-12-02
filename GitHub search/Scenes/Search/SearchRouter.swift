//
//  SearchRouter.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit

protocol SearchRoutingLogic {
    func routeToBrowser()
    func prepareForNextScene(segue: UIStoryboardSegue)
}

protocol SearchDataPassing {
    var dataStore: SearchDataStore? { get }
}

final class SearchRouter: SearchRoutingLogic, SearchDataPassing {
    
    weak var viewController: SearchViewController?
    var dataStore: SearchDataStore?
    
    private static let _browserSegue = "MVCBrowserViewController"
    
    // MARK: - Routing
    
    func routeToBrowser() {
        viewController?.performSegue(withIdentifier: SearchRouter._browserSegue, sender: nil)
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
