//
//  FavoritesViewController.swift
//  AppOfThrones
//
//  Created by Gerardo Rico Botella on 27/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EpisodeTableViewCellDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var favoriteEpisodes: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let episodeCell = UINib.init(nibName: "EpisodeTableViewCell", bundle: nil)
        table.register(episodeCell, forCellReuseIdentifier: "EpisodeTableViewCell")
        
        self.title = "Favorites"
        self.table.delegate = self
        self.table.dataSource = self
        
        self.loadFavorites()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didFavoriteChanged), name: .didFavoritesChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didFavoritesChanged, object: nil)
    }
    
    @objc func didFavoriteChanged() {
        self.loadFavorites()
    }
    
    func loadFavorites() {
        let favorites = DataController.shared.getFavorites(ofType: Episode.self)
        
        favoriteEpisodes = EpisodesRepository.shared.all().filter { (episode) -> Bool in
            return favorites.contains { (favorite) -> Bool in
                    return favorite.id == episode.id
            }
        }
        
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = favoriteEpisodes[indexPath.row]
        
        let episodeDetailVC = EpisodeDetailViewController.init(episode: episode)
        
        self.present(episodeDetailVC, animated: true, completion: nil)
        
        table.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteEpisodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = table.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell") as?  EpisodeTableViewCell else {
            fatalError("Unable to dequeue cell EpisodeTableViewCell")
        }
        
        cell.setEpisode(favoriteEpisodes[indexPath.row])
        cell.delegate = self
        
        return cell
    }
}
