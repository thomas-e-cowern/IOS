//
//  AddRoomVC.swift
//  TheDumpList
//
//  Created by Thomas Cowern New on 8/30/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import UIKit

class AddRoomVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var roomLabel: UILabel!
    
    @IBOutlet weak var roomText: UITextField!
    
    @IBOutlet weak var roomPicker: UIPickerView!
    
    var roomData: [String] = []
    
    
    
    @IBAction func addPressed(_ sender: Any) {
        
        let newRoom = roomText.text
        
        if newRoom == "" {
            
            roomText.placeholder = "Please add a room or location!"
            
            roomLabel.textColor = .red
            
            roomLabel.text = "Please enter a room or location before pressing enter!"
            
            
        } else {
            
            roomData.append(newRoom!)
            
            roomPicker.reloadAllComponents()
            
            roomText.text = ""
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.roomPicker.delegate = self
        self.roomPicker.dataSource = self
        
        roomData = ["Bedroom", "Kitchen", "Bathroom", "Dining Room"]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roomData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return roomData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
}
