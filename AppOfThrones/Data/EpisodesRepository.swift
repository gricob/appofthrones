//
//  EpisodesController.swift
//  AppOfThrones
//
//  Created by Gerardo Rico Botella on 27/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import Foundation

class EpisodesRepository {
    
    static let shared = EpisodesRepository()
    
    private init(){}
    
    func all() -> [Episode] {
        var episodes: [Episode] = []
        
        for season in 1...8 {
            episodes += self.loadEpisodes(ofSeason: season)
        }
        
        return episodes
    }
    
    func getEpisodes(ofSeason season: Int) -> [Episode] {
        return self.loadEpisodes(ofSeason: season)
    }
    
    private func loadEpisodes(ofSeason season: Int) -> [Episode] {
        if let pathURL = Bundle.main.url(forResource: "season_\(season)", withExtension: "json") {
            do {
                let data = try Data.init(contentsOf: pathURL)
                let decoder = JSONDecoder()
                return try decoder.decode([Episode].self, from: data)
            } catch {
                fatalError("Could not read the JSON")
            }
        } else {
            fatalError("Could not build the path url")
        }
    }
}
