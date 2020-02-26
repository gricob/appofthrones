//
//  Cast.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 08/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import Foundation

class Cast: Identifiable, Codable, CustomStringConvertible, Equatable {

    var id: Int
    var avatar: String?
    var fullname: String?
    var role: String?
    var episodes: Int?
    var birth: String?
    var placeBirth: String?
    
    var description: String {
        return "Cast:\n"
            + "\tid:\(id)\n"
            + "\tavatar:\(String(describing: avatar))\n"
            + "\tfullname:\(String(describing: fullname))\n"
            + "\trole: \(String(describing: role))\n"
            + "\tepisodes:\(String(describing: episodes))\n"
            + "\tbirth:\(String(describing: birth))\n"
            + "\tplaceBirth:\(String(describing: placeBirth))\n"
    }
    
    init(id: Int, avatar: String? = nil, fullname: String? = nil, role: String? = nil, episodes: Int? = nil, birth: String? = nil, placeBirth: String? = nil) {
        self.id = id
        self.avatar = avatar
        self.fullname = fullname
        self.role = role
        self.episodes = episodes
        self.birth = birth
        self.placeBirth = placeBirth
    }
    
    static func == (lhs: Cast, rhs: Cast) -> Bool {
        return lhs.id == rhs.id
    }

}
