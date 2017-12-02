//
//  MVCBrowserViewController.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit
import WebKit

protocol MVCBrowserDisplayLogic: class {
}

protocol MVCBrowserDataPassing: class {
    var dataStore: MVCBrowserDataStore? { get }
}

protocol MVCBrowserRoutingLogic: class {
}

protocol MVCBrowserBusinessLogic: class {
}

protocol MVCBrowserDataStore: class {
    var url: URL? { get set }
}


class MVCBrowserViewController: UIViewController, MVCBrowserDataPassing, MVCBrowserDataStore {
    
    @IBOutlet var webView: WKWebView!
    
    var router: MVCBrowserDataPassing?
    var dataStore: MVCBrowserDataStore?
    
    var url: URL?

    // MARK: - Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        _setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        _setup()
    }
    
    private func _setup() {
        router = self
        dataStore = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        
    }
    
}
