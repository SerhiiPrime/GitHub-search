//
//  SearchWorker.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright (c) 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RxSwift

final class SearchWorker {

    private let _service: NetworkServiceProtocol
    
    init(service: NetworkServiceProtocol = NetworkService.shared) {
        _service = service
    }
    
    func loadRepos(_ query: String) -> Observable<[Repo]> {        
        return _service.getRepos(query)
    }
}
