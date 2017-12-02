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
    
    func updateTableWithModels(_ viewModel: Search.Repository.ViewModel)
    
    func displayBrowser(_ viewModel: Search.SelectRepo.ViewModel)
    
    func displayAuthAlert(_ viewModel: Search.Auth.ViewModel)
}

final class SearchViewController: UIViewController, SearchDisplayLogic {
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var interactor: SearchBusinessLogic?
    var router: (SearchRoutingLogic & SearchDataPassing)?
    
    private let _disposeBag = DisposeBag()
    
    fileprivate var repos: [Search.CellModel] = []
    
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
        router?.prepareForNextScene(segue: segue)
    }
    
    // MARK: - Display logic
    
    func updateTableWithModels(_ viewModel: Search.Repository.ViewModel) {
        repos = viewModel.repos
        tableView.reloadData()
    }
    
    func displayBrowser(_ viewModel: Search.SelectRepo.ViewModel) {
        router?.routeToBrowser()
    }
    
    func displayAuthAlert(_ viewModel: Search.Auth.ViewModel) {
        
        let alert = UIAlertController(title: viewModel.title,
                                      message: viewModel.text,
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: viewModel.cancel, style: .cancel, handler: nil)
        
        let logInAction = UIAlertAction(title: viewModel.login, style: .default) { [weak self] _ in
            self?.router?.routeToAuth()
        }
        
        alert.addAction(logInAction)
        alert.addAction(cancelAction)
        alert.preferredAction = logInAction
        present(alert, animated: true)
    }
    
    // MARK: - Private
    
    private func _setupSearchBar() {
        searchBar.rx.text.orEmpty
            .skip(1)
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                self?.interactor?.searchRepo(.init(name: text))
            }).disposed(by: _disposeBag)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = repos[indexPath.row].model
        let cell = tableView.dequeueReusableCell(withModel: model, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor?.didSelectRepo(.init(index: indexPath.row))
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        interactor?.verifyUserAuth(.init())
    }
}



