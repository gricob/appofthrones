//
//  Rating.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import Foundation

enum Rate {
    case unrated
    case rated(value: Int)
}

struct Rating {
    var id: Int
    var rate: Rate
}
