//
//  Favorite.swift
//  AppOfThrones
//
//  Created by Gerardo Rico Botella on 27/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import Foundation

struct Favorite: Equatable {
    
    var id: Int
    var type: Any.Type
    
    static func == (lhs: Favorite, rhs: Favorite) -> Bool {
        return lhs.id == rhs.id && lhs.type == rhs.type
   }
}
