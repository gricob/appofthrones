//
//  EpisodeInfoTableViewCell.swift
//  AppOfThrones
//
//  Created by Gerardo Rico Botella on 25/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    func setInfo(title: String, content: String?) {
        self.title.text = title
        self.content.text = content
    }
}
