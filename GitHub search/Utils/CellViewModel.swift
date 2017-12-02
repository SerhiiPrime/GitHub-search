//
//  CellViewModel.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import UIKit

protocol CellViewAnyModel {
    static var cellAnyType: UIView.Type { get }
    var identifier: String { get }
    func setupAny(cell: UIView)
}

protocol CellViewModel: CellViewAnyModel {
    associatedtype CellType: UIView
    func setup(cell: CellType)
}

extension CellViewModel {
    
    static var cellAnyType: UIView.Type {
        return CellType.self
    }
    
    func setupAny(cell: UIView) {
        guard let cell = cell as? CellType else { return }
        setup(cell: cell)
    }
    
    var identifier: String {
        return String(describing: type(of: self).cellAnyType)
    }
}
