//
//  PokedexViewController.swift
//  Pokemon-Go-Clone
//
//  Created by Thomas Cowern New on 9/16/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var caughtPokemons : [Pokemon] = []
    var uncaughtPokemons : [Pokemon] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        caughtPokemons = getCaughtPokemon()
        uncaughtPokemons = getUnCaughtPokemon()
        
        print("Caught pokemons: \(caughtPokemons.count)")
        print("Uncaught pokemons: \(uncaughtPokemons.count)")
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "CAUGHT"
        } else {
            return "UNCAUGHT"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return caughtPokemons.count
        } else {
            return uncaughtPokemons.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var pokemon : Pokemon
        
        if indexPath.section == 0 {
            pokemon = caughtPokemons[indexPath.row]
        } else {
            pokemon = uncaughtPokemons[indexPath.row]
        }
        
        if let imageName = pokemon.imageName {
        
            cell.imageView?.image = UIImage(named: imageName)
        }
        cell.textLabel?.text = pokemon.name
        
        return cell
    }
    
    @IBAction func returnTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
