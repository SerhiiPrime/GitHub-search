//
//  RepoCell.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/2/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var viewStatusLabel: UILabel!
    @IBOutlet var urlLabel: UILabel!
    
}

struct RepoCellModel {
    let name: String
    let statusIsHidden: Bool
    let urlString: String
}

extension RepoCellModel: CellViewModel {
    
    func setup(cell: RepoCell) {
        cell.nameLabel.text = name
        cell.viewStatusLabel.isHidden = statusIsHidden
        cell.urlLabel.text = urlString
    }
}
