//
//  EpisodeInfoTableViewCell.swift
//  AppOfThrones
//
//  Created by Gerardo Rico Botella on 25/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

struct EpisodeInfo {
    var title: String
    var content: String?
}

class EpisodeInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    func setInfo(_ info: EpisodeInfo) {
        self.title.text = info.title
        self.content.text = info.content
    }
}
