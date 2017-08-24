//
//  AddToDoVC.swift
//  ToDoList
//
//  Created by Thomas Cowern New on 8/23/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import UIKit

class AddToDoVC: UIViewController {
    
    var previousVC = ToDoTVC()
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var importantSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        
            let toDo = ToDoCoreData(entity: ToDoCoreData.entity(), insertInto: context)
            
            if let newItem = titleTextField.text {
                
                toDo.name = newItem
                
                toDo.important = importantSwitch.isOn
            }
            
            try? context.save()
            navigationController?.popViewController(animated: true)
            
        }
    }
}
