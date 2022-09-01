//
//  DetailViewController.swift
//  Marvel
//
//  Created by Mustafa Berkan Vay on 01.09.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
  @IBOutlet private weak var ImageView: UIImageView!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var comicsLabel: UILabel!
  var hero : Hero?
  var validComics = [ComicsItem]()
  override func viewDidLoad() {
    super.viewDidLoad()
    setProperties()
  }
}

extension DetailViewController {
  
  private func setProperties() {
    
    guard let hero = hero else { return }
    
    /// Setting Hero image
    ImageView.kf.setImage(with: hero.thumbnailURL)
    nameLabel.text = hero.name
    
    /// Setting Hero description
    if hero.description.isEmpty {
      descriptionLabel.text = "This hero doesn't have any description."
    }
    else {
      descriptionLabel.text = hero.description
    }
    
    /// Setting Hero valid comics
    extractComics()
    sort()
    printComicsLabel()
    
    func extractComics() {
      for comic in hero.comics.items {
        if let year = comic.year, year > 2005 {
          validComics.append(comic)
        }
      }
    }
    
    func sort(){
      validComics.sort {  $0.year! > $1.year!}
    }
    
    func printComicsLabel(){
      comicsLabel.text = ""
      if validComics.isEmpty {
        comicsLabel.text = "This hero doesn't have any comic."
      }
      else {
        let endIndex = validComics.count > 10 ? 9 : validComics.count - 1
        for index in 0...endIndex{
          comicsLabel.text = comicsLabel.text! + "\(validComics[index].name)\n"
        }
      }
    }
  }
}
