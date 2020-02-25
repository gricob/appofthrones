//
//  House.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import Foundation

class House: Codable {
    
    var imageName: String?
    var name: String?
    var words: String?
    var seat: String?
    
    init(imageName: String?, name: String?, words: String?, seat: String?) {
        self.imageName = imageName
        self.name  = name
        self.words = words
        self.seat  = seat
    }
}
