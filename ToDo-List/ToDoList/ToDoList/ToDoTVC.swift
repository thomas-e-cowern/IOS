//
//  ToDoTVC.swift
//  ToDoList
//
//  Created by Thomas Cowern New on 8/23/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import UIKit

class ToDoTVC: UITableViewController {
    
    var toDos : [ToDoCoreData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }
    
    func getToDos () {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let coreDataToDos = try? context.fetch(ToDoCoreData.fetchRequest()) as? [ToDoCoreData] {
                
                if let theToDos = coreDataToDos {
                    
                    toDos = theToDos
                    tableView.reloadData()
                    
                }
            }
        }
    }
    
    func createToDos () -> [ToDo] {

        let eggs = ToDo()
        eggs.name = "Buy Eggs"
        eggs.important = true

        let dog = ToDo()
        dog.name = "Lily"
        dog.important = true

        let cheese = ToDo()
        cheese.name = "Eat Cheese"
        cheese.important = false

        return [eggs, dog, cheese]

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let toDo = toDos[indexPath.row]
        
        if let name = toDo.name {
            
            if toDo.important {
                
                cell.textLabel?.text = "❗️" + name
                
            } else {
                
                cell.textLabel?.text = toDo.name
                
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDos[indexPath.row]
        performSegue(withIdentifier: "moveToComplete", sender: toDo )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddToDoVC {
            
            addVC.previousVC = self
            
        }
        
        if let completeVC = segue.destination as? completeVC {
            
            if let toDo = sender as? ToDoCoreData {
                
                completeVC.selectedToDo = toDo
                completeVC.previousVC = self
                
            }
        }
    }
}
