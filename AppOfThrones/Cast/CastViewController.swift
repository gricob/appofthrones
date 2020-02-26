//
//  CastViewController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class CastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CastTableViewCellDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var cast: [Cast] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
        self.setupUI()
    }

    // MARK: - Setup
    
    func setupData() {
        if let pathURL = Bundle.main.url(forResource: "cast", withExtension: "json") {
            do {
                let data = try Data.init(contentsOf: pathURL)
                let decoder = JSONDecoder()
                cast = try decoder.decode([Cast].self, from: data)
                if let splitViewController = self.splitViewController,
                    splitViewController.viewControllers.count > 1 {
                    if let navigationController = splitViewController.viewControllers[1] as? UINavigationController,
                        let detailViewController = navigationController.visibleViewController as? CastDetailViewController {
                        if cast.count > 0 {
                            detailViewController.cast = cast[0]
                        }
                    }
                }
                table.reloadData()
            } catch {
                fatalError("Could not read the JSON")
            }
        } else {
            fatalError("Could not build the path url")
        }
    }
    
    func setupUI() {
        self.title = "Cast"
        
        let nib = UINib.init(nibName: "CastTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "CastTableViewCell")
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cast = self.cast[indexPath.row]
        
        if let splitViewController = self.splitViewController,
            splitViewController.viewControllers.count > 1 {
            if let navigationController = splitViewController.viewControllers[1] as? UINavigationController,
                let detailViewController = navigationController.visibleViewController as? CastDetailViewController {
                detailViewController.cast = cast
            }
        } else {
            let castDetailVC = CastDetailViewController.init(cast: cast)
            self.navigationController?.pushViewController(castDetailVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - UITableViewDatasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as? CastTableViewCell {
            cell.setCast(cast[indexPath.row])
            cell.delegate = self
            return cell
        }
        fatalError("Could not create cast cells")
    }
    
    // MARK: - CastTableViewCellDelegate
    
    func didFavoriteChanged() {
        table.reloadData()
    }
}
