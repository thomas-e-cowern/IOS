//
//  ViewCollectionTVC.swift
//  Collector
//
//  Created by Thomas Cowern New on 8/24/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import UIKit


class ViewCollectionTVC: UITableViewController {
    
    var items : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getItems()
    }
    
    func getItems() {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let coreDataStuff = try? context.fetch(Item.fetchRequest()) as? [Item] {
                
                if let coreDataItems = coreDataStuff {
                    
                    items = coreDataItems
                    tableView.reloadData()
                    
                }
                
            }
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        if let imageData = item.image {
            
            cell.imageView?.image = UIImage(data: imageData)
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                let item = items[indexPath.row]
                
                context.delete(item)
                
                try? context.save()
                
                getItems()
                
            }
        }
    }
}
