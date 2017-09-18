//
//  CoreDataHelper.swift
//  Pokemon-Go-Clone
//
//  Created by Thomas Cowern New on 9/16/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Foundation
import UIKit
import CoreData

func addAllPokemon() {
    print("Add all pokemon hit")
    creatPokemon(name: "Pikachu", imageName: "pikachu-2")
    creatPokemon(name: "Abra", imageName: "abra")
    creatPokemon(name: "Bellsprout", imageName: "bellsprout")
    creatPokemon(name: "Bullbasaur", imageName: "bullbasaur")
    creatPokemon(name: "Caterpie", imageName: "caterpie")
    creatPokemon(name: "Charmander", imageName: "charmander")
    creatPokemon(name: "dratini", imageName: "dratini")
    creatPokemon(name: "Eevee", imageName: "eevee")
    creatPokemon(name: "Jigglypuff", imageName: "jigglypuff")
    creatPokemon(name: "Mankey", imageName: "mankey")
    
    
}

func creatPokemon(name:String, imageName:String) {
    if let context = (UIApplication.shared.delegate as?AppDelegate)?.persistentContainer.viewContext {
        let pokemon = Pokemon(entity: Pokemon.entity(), insertInto: context)
        pokemon.name = name
        pokemon.imageName = imageName
        try? context.save()
    }
}

func getAllPokemon() -> [Pokemon] {
    
    if let context = (UIApplication.shared.delegate as?AppDelegate)?.persistentContainer.viewContext {

        if let pokeData = try? context.fetch(Pokemon.fetchRequest()) as? [Pokemon] {
            if let pokemons = pokeData {
                print("get all pokemons count: \(pokemons.count)")
                if pokemons.count == 0 {
                    addAllPokemon()
                    return getAllPokemon()
                }

                return pokemons
            }
        }
    }
    return []
}

func getCaughtPokemon() -> [Pokemon] {
    if let context = (UIApplication.shared.delegate as?AppDelegate)?.persistentContainer.viewContext {
        let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
        fetchRequest.predicate = NSPredicate(format: "caught == %@", true as CVarArg)
        if let pokemons = try? context.fetch(fetchRequest)  {
            print("getCaughtPokemon: \(pokemons)")
                return pokemons
        }
    }
    
    return []
}

func getUnCaughtPokemon() -> [Pokemon] {
    if let context = (UIApplication.shared.delegate as?AppDelegate)?.persistentContainer.viewContext {
        let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
        fetchRequest.predicate = NSPredicate(format: "caught == %@", false as CVarArg)
        if let pokemons = try? context.fetch(fetchRequest)  {
            print("getUnCaughtPokemon: \(pokemons)")
            return pokemons
        }
    }
    
    return []
}
