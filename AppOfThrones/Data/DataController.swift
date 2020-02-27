//
//  DataController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import Foundation

protocol Identifiable {
    var id: Int { get }
}

extension Notification.Name {
    static let didFavoritesChanged = Notification.Name("DidFavoritesChanged")
}

class DataController {
    
    private var favorites: [Favorite] = []
    private var rating: [Rating] = []
    
    static let shared = DataController()
    private init(){}
    
    // MARK: - Favorite

    func isFavorite<T: Identifiable>(_ value: T) -> Bool {
        return favorites.contains(Favorite.init(id: value.id, type: T.self))
    }
    
    func addFavorite<T: Identifiable>(_ value: T) {
        if self.isFavorite(value) == false {
            favorites.append(Favorite.init(id: value.id, type: T.self))
            
            NotificationCenter.default.post(name: .didFavoritesChanged, object: nil)
        }
    }
    
    func removeFavorite<T: Identifiable>(_ value: T) {
        if let index = favorites.firstIndex(of: Favorite.init(id: value.id, type: T.self)) {
            favorites.remove(at: index)
            
            NotificationCenter.default.post(name: .didFavoritesChanged, object: nil)
        }
    }
    
    func getFavorites(ofType type: Any.Type) -> [Favorite] {
        return favorites.filter { (favorite) -> Bool in
            return favorite.type == type
        }
    }
    
    func clearFavorites(ofType type: Any.Type) {
        favorites = favorites.filter { (favorite) -> Bool in
            return favorite.type != type
        }
        
        NotificationCenter.default.post(name: .didFavoritesChanged, object: nil)
    }
 
    // MARK: - Rating
    
    func rateEpisode(_ episode: Episode, value: Int) {
        if self.ratingForEpisode(episode) == nil {
            let value = Rating.init(id: episode.id, rate: .rated(value: value))
            rating.append(value)
        }
    }
    
    func removeRateEpisode(_ episode: Episode) {
        if let index = self.rating.firstIndex(where: { (rating) -> Bool in
                return episode.id == rating.id
        }) {
            self.rating.remove(at: index)
        }
    }
    
    func ratingForEpisode(_ episode: Episode) -> Rating? {
        let filtered = rating.filter { (rating) -> Bool in
            return rating.id == episode.id
        }
        return filtered.first
    }
    
    func clearAllEpisodeRatings() {
        rating.removeAll()
    }
}
