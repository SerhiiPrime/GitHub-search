//
//  SearchViewController.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol SearchDisplayLogic: class {
    // func displaySomething(viewModel: Search.Something.ViewModel)
}

final class SearchViewController: UIViewController, SearchDisplayLogic {

    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var interactor: SearchBusinessLogic?
    var router: (SearchRoutingLogic & SearchDataPassing)?

    private let _disposeBag = DisposeBag()
    
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
        _setupSearchBar()
    }

    // MARK: - Setup

    private func _setup() {
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
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

    // func displaySomething(viewModel: Search.Something.ViewModel) {
    //
    // }
    
    // MARK: - Private
    
    private func _setupSearchBar() {
        let searchText = searchBar.rx.text.orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        
        searchText.subscribe(onNext: { [weak self] text in
            self?.interactor?.searchRepo(request: .init(name: text))
        }).disposed(by: _disposeBag)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        interactor?.verifyUserAuth(request: .init())
    }
}



