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
    
    private var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    
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
        
        if let url = url {
            webView.load(URLRequest(url: url))
        }
    }
    
    // MARK: - Event Handling
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == UIGestureRecognizerState.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizerState.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0,
                                         y: touchPoint.y - initialTouchPoint.y,
                                         width: self.view.frame.size.width,
                                         height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0,
                                             y: 0,
                                             width: self.view.frame.size.width,
                                             height: self.view.frame.size.height)
                })
            }
        }
    }
}
