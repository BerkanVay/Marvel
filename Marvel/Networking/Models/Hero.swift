//
//  Hero.swift
//  Marvel
//
//  Created by Mustafa Berkan Vay on 01.09.2022.
//

import Foundation
import UIKit

struct Hero: Codable {
  let id: Int
  let name: String
  let description: String
  let thumbnail: Thumbnail
  let comics: Comics
  var thumbnailURL: URL{
    let newThumbnailPath = thumbnail.path.replacingOccurrences(of: "http://", with: "https://")
    let url = "\(newThumbnailPath).\(thumbnail.extension)"
    let imageURL = URL(string: url)
    return imageURL!
  }
  
  enum CodingKeys: String, CodingKey{
    case id
    case name
    case description
    case thumbnail
    case comics
  }
  
  struct Comics: Codable {
    let items: [ComicsItem]
  }
  
  struct Thumbnail: Codable {
    let path: String
    let `extension`: String
  }
}

struct ComicsItem: Codable {
  let name: String
  var year: Int?{
    let Comics = name.split(separator: "(")
    let ComicsYear = Comics.last?.split(separator: ")").first.flatMap{Int($0)}
    return ComicsYear
  }
}
