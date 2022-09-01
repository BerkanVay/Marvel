//
//  HeroTableViewCell.swift
//  Marvel
//
//  Created by Mustafa Berkan Vay on 01.09.2022.
//

import UIKit
import Kingfisher

class HeroTableViewCell: UITableViewCell {
  static let identifier = "HeroTableViewCell"
  @IBOutlet private weak var heroImageView: UIImageView!
  @IBOutlet private weak var heroNameLabel: UILabel!
  
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
