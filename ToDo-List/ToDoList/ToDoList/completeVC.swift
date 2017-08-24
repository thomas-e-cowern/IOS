//
//  completeVC.swift
//  ToDoList
//
//  Created by Thomas Cowern New on 8/23/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import UIKit


class completeVC: UIViewController {
    
    var previousVC = ToDoTVC()
    var selectedToDo : ToDoCoreData?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = selectedToDo?.name
    }
    
    @IBAction func completeTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        
            if let theToDo = selectedToDo {
            
                context.delete(theToDo)
                
                navigationController?.popViewController(animated: true)
            }
        }
//        var index = 0
//
//        for toDo in previousVC.toDos {
//
//            if toDo.name == selectedToDo.name {
//
//                previousVC.toDos.remove(at: index)
//                previousVC.tableView.reloadData()
//                navigationController?.popViewController(animated: true)
//                break
//            }
//
//            index += 1
//    }
//
    }
    
}
