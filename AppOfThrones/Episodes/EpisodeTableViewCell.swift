//
//  EpisodeTableViewCell.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 08/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

protocol EpisodeTableViewCellDelegate: class {
    func didFavoriteChanged()
}

class EpisodeTableViewCell: UITableViewCell {
    
    private weak var episode: Episode?
    weak var delegate: EpisodeTableViewCellDelegate?
    
    var rateBlock: (()->Void)?
    
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var star01: UIImageView!
    @IBOutlet weak var star02: UIImageView!
    @IBOutlet weak var star03: UIImageView!
    @IBOutlet weak var star04: UIImageView!
    @IBOutlet weak var star05: UIImageView!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var heart: UIImageView!
    
    override func awakeFromNib() {
        thumb.layer.cornerRadius = 2.0
        thumb.layer.borderColor  = UIColor.white.withAlphaComponent(0.2).cgColor
        thumb.layer.borderWidth  = 1.0
        rateButton.layer.cornerRadius = 15
        
        self.modeRate()
    }
    
    // MARK: - Rating
    
    func modeRate() {
        rateButton.isHidden = false
        ratingLabel.isHidden = true
        star01.isHidden = true
        star02.isHidden = true
        star03.isHidden = true
        star04.isHidden = true
        star05.isHidden = true
    }
    
    func setRating(_ rate: Int) {
        rateButton.isHidden = true
        ratingLabel.isHidden = false
        star01.isHidden = false
        star02.isHidden = false
        star03.isHidden = false
        star04.isHidden = false
        star05.isHidden = false
        
        let emptyStar = UIImage.init(systemName: "star")
        let filledStar = UIImage.init(systemName: "star.fill")
        
        star01.image = rate > 0 ? filledStar : emptyStar
        star02.image = rate > 1 ? filledStar : emptyStar
        star03.image = rate > 2 ? filledStar : emptyStar
        star04.image = rate > 3 ? filledStar : emptyStar
        star05.image = rate > 4 ? filledStar : emptyStar
    }
    
    // MARK: - Setter
    
    func setEpisode(_ episode: Episode) {
        self.episode = episode
        thumb.image = episode.image == nil ? nil : UIImage.init(named: episode.image!)
        title.text  = episode.name
        date.text   = episode.date
        
        if let ratingValue = DataController.shared.ratingForEpisode(episode) {
            switch ratingValue.rate {
            case .rated(let value):
                ratingLabel.text = String(value)
                self.setRating(value)
            case .unrated:
                self.modeRate()
            }
        } else {
            self.modeRate()
        }
        
        let systemName = DataController.shared.isFavorite(episode) ? "heart.fill" : "heart"
        heart.image = UIImage.init(systemName: systemName)
    }
    
    // MARK: - IBAction
    
    @IBAction func rate(_ sender: Any) {
        self.rateBlock?()
    }
    
    @IBAction func favoriteAction() {
        if let episode = episode {
            if DataController.shared.isFavorite(episode) {
                DataController.shared.removeFavorite(episode)
            } else {
                DataController.shared.addFavorite(episode)
            }
            delegate?.didFavoriteChanged()
        }
    }
}
