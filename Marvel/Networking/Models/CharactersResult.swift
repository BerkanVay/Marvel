//
//  CharacterResult.swift
//  Marvel
//
//  Created by Mustafa Berkan Vay on 01.09.2022.
//

import Foundation

struct CharactersResult: Codable {
  let data: HeroData
}

struct HeroData: Codable {
  let results: [Hero]
}
