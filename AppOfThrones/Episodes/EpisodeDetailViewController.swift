//
//  EpisodeDetailViewController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 10/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var episode: Episode? {
        didSet {
            self.title = episode?.name
            self.table?.reloadData()
        }
    }
    
    convenience init(episode: Episode) {
        self.init(nibName: "EpisodeDetailViewController", bundle: nil)
        
        self.episode = episode
    }
    
    override func viewDidLoad() {
        self.table.delegate = self
        self.table.dataSource = self
        
        let headerNib = UINib.init(nibName: "EpisodeHeaderTableViewCell", bundle: nil)
        table.register(headerNib, forCellReuseIdentifier: "EpisodeHeaderTableViewCell")
        
        let infoNib = UINib.init(nibName: "EpisodeInfoTableViewCell", bundle: nil)
        table.register(infoNib, forCellReuseIdentifier: "EpisodeInfoTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = indexPath.row == 0 ? "EpisodeHeaderTableViewCell" : "EpisodeInfoTableViewCell"
        
        guard let cell = table.dequeueReusableCell(withIdentifier: cellId) else {
            fatalError("Could not create \(cellId)")
        }
        
        guard let episode = episode else {
            return cell
        }
        
        switch indexPath.row {
        case 0:
            (cell as! EpisodeHeaderTableViewCell).setThumbnail(episode.image)
        case 1:
            (cell as! EpisodeInfoTableViewCell).setInfo(
                EpisodeInfo.init(title: "Name", content: episode.name)
            )
        case 2:
            (cell as! EpisodeInfoTableViewCell).setInfo(
                EpisodeInfo.init(title: "Season", content: String(episode.season))
            )
        case 3:
            (cell as! EpisodeInfoTableViewCell).setInfo(
                EpisodeInfo.init(title: "Date", content: episode.date)
            )
        case 4:
            (cell as! EpisodeInfoTableViewCell).setInfo(
                EpisodeInfo.init(title: "Overview", content: episode.overview)
            )
        default:
            return cell
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
