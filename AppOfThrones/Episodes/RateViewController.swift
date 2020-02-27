//
//  RateViewController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {
    
    private var episode: Episode?
    
    private var confirmed: (() -> Void)?
    
    var rate: Int = 0
    
    @IBOutlet weak var confirmButton: UIButton!

    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    convenience init(withEpisode episode: Episode, confirmed: (() -> Void)?) {
        self.init(nibName: "RateViewController", bundle: nil)
        self.episode = episode
        self.confirmed = confirmed
        self.title = episode.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.layer.cornerRadius = 4.0
    }
    
    @IBAction func confirm(_ sender: Any) {
        if let episode = episode {
            DataController.shared.rateEpisode(episode, value: rate)
        }
        
        self.confirmed?()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rate(_ sender: UIButton) {
        self.rate = sender.tag
        
        let emptyStar = UIImage.init(systemName: "star")
        let filledStar = UIImage.init(systemName: "star.fill")
        
        star1.setImage(rate > 0 ? filledStar : emptyStar, for: .normal)
        star2.setImage(rate > 1 ? filledStar : emptyStar, for: .normal)
        star3.setImage(rate > 2 ? filledStar : emptyStar, for: .normal)
        star4.setImage(rate > 3 ? filledStar : emptyStar, for: .normal)
        star5.setImage(rate > 4 ? filledStar : emptyStar, for: .normal)
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
