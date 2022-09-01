//
//  HeroTableViewCell.swift
//  Marvel
//
//  Created by Mustafa Berkan Vay on 01.09.2022.
//

import UIKit
import Kingfisher

class HeroTableViewCell: UITableViewCell {
  
  @IBOutlet weak var heroImageView: UIImageView!
  @IBOutlet weak var heroNameLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension HeroTableViewCell {
  func configure(withHero hero: Hero) {
    heroImageView.kf.setImage(with: hero.thumbnailURL)
    heroNameLabel.text = hero.name
  }
}
