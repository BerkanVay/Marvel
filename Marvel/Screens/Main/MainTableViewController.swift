//
//  MainTableViewController.swift
//  Marvel
//
//  Created by Mustafa Berkan Vay on 01.09.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
  
  private let APIKey = "9a0775362c118bd1580230b4f9beffc1"
  private let privateAPIKey = "dd623b1efade5ce8701dc78c37ec77ee22cc7291"
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
    if segue.identifier == "showDetailViewController" {
      if let destinationViewController = segue.destination as? DetailViewController, let selectedHero = selectedHero{
        destinationViewController.hero = selectedHero
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedHero = heros[indexPath.row]
    performSegue(withIdentifier: "showDetailViewController", sender: self)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HeroTableViewCell", for: indexPath) as? HeroTableViewCell
    let hero = heros[indexPath.row]
    cell?.configure(withHero: hero)
    return cell!
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(140)
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
    self.tableView.register(heroTableCell,
                            forCellReuseIdentifier: "HeroTableViewCell")
  }
  
  private func fetchHeros(offset: Int) {
    MarvelRESTClient.getCharacterResult(offset: offset, APIKey: APIKey, privateAPIKey: privateAPIKey, ts: ts) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case let .success(characterResponse):
        DispatchQueue.main.async {
          self.heros.append(contentsOf: characterResponse.data.results)
          self.tableView.reloadData()
        }
        
      case let .failure(error):
        // TODO: Handle the error
        
        print(error)
      }
    }
  }
  
}
