//
//  CastDetailViewController.swift
//  AppOfThrones
//
//  Created by Gerardo Rico Botella on 26/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class CastDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var cast: Cast? {
        didSet {
            self.table?.reloadData()
        }
    }
    
    convenience init(cast: Cast) {
        self.init(nibName: "CastDetailViewController", bundle: nil)
        
        self.cast = cast
    }
    
    override func viewDidLoad() {
        self.table.delegate = self
        self.table.dataSource = self
        
        let headerNib = UINib.init(nibName: "ThumbnailTableViewCell", bundle: nil)
        self.table.register(headerNib, forCellReuseIdentifier: "ThumbnailTableViewCell")
        let infoNib = UINib.init(nibName: "InfoTableViewCell", bundle: nil)
        self.table.register(infoNib, forCellReuseIdentifier: "InfoTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = indexPath.row == 0 ? "ThumbnailTableViewCell" : "InfoTableViewCell"
        
        guard let cell = table.dequeueReusableCell(withIdentifier: cellId) else {
            fatalError("Could not create \(cellId)")
        }
        
        guard let cast = cast else {
            return cell
        }
        
        switch indexPath.row {
        case 0:
            (cell as! ThumbnailTableViewCell).setThumbnail(cast.avatar)
        case 1:
            (cell as! InfoTableViewCell).setInfo(title: "Name", content: cast.fullname)
        case 2:
            (cell as! InfoTableViewCell).setInfo(title: "Role", content: cast.role)
        case 3:
            (cell as! InfoTableViewCell).setInfo(title: "Episodes", content: String(cast.episodes != nil ? cast.episodes! : 0))
        case 4:
            (cell as! InfoTableViewCell).setInfo(title: "Birth", content: cast.birth)
        case 5:
            (cell as! InfoTableViewCell).setInfo(title: "Birth place", content: cast.placeBirth)
        default:
            return cell
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 350 : UITableView.automaticDimension
    }
}
