//
//  MainTableViewController.swift
//  Marvel
//
//  Created by Mustafa Berkan Vay on 01.09.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
  private let apiKey = "9a0775362c118bd1580230b4f9beffc1"
  private let privateApiKey = "dd623b1efade5ce8701dc78c37ec77ee22cc7291"
  private let segueIdentifier = "showDetailViewController"
  private let ts = "1"
  private var heros = [Hero]()
  private var offset = 0
  private var selectedHero: Hero?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.registerTableViewCells()
    fetchHeros(offset: offset)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    heros.count
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == segueIdentifier {
      if let destinationViewController = segue.destination as? DetailViewController, let selectedHero = selectedHero{
        destinationViewController.hero = selectedHero
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedHero = heros[indexPath.row]
    performSegue(withIdentifier: segueIdentifier , sender: self)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HeroTableViewCell", for: indexPath) as? HeroTableViewCell
    let hero = heros[indexPath.row]
    cell?.configure(withHero: hero)
    return cell ?? UITableViewCell()
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 140
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
      offset += 20
      fetchHeros(offset: offset)
    }
  }
  
  private func registerTableViewCells() {
    let heroTableCell = UINib(nibName: "HeroTableViewCell",
                              bundle: nil)
    tableView.register(heroTableCell,
                       forCellReuseIdentifier: "HeroTableViewCell")
  }
  
  private func fetchHeros(offset: Int) {
    MarvelRESTClient.getCharacterResult(offset: offset, apiKey: apiKey, privateApiKey: privateApiKey, ts: ts) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case let .success(characterResponse):
        DispatchQueue.main.async {
          self.heros.append(contentsOf: characterResponse.data.results)
          self.tableView.reloadData()
        }
        
      case let .failure(error):
        print(error)
      }
    }
  }
  
}
