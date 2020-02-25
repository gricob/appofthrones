//
//  EpisodeHeaderTableViewCell.swift
//  AppOfThrones
//
//  Created by Gerardo Rico Botella on 25/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class EpisodeHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    func setThumbnail(_ thumb: String?) {
        if let thumb = thumb {
            self.thumbnail.image = UIImage.init(named: thumb)
        }
        
    }
}
