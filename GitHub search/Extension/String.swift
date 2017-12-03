//
//  String.swift
//  GitHub search
//
//  Created by Serhii Onopriienko on 12/3/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation

extension String {

    func trunc(length: Int, trailing: String = "…") -> String {
        return (self.count > length) ? self.prefix(length) + trailing : self
    }
}
