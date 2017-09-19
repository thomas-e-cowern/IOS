//
//  SelectUserTableViewController.swift
//  Snapchat-Clone
//
//  Created by Thomas Cowern New on 9/15/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SelectUserTableViewController: UITableViewController {

    var imageName = ""
    var imageURL = ""
    var message = ""
    var users : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(imageName)
        print(imageURL)
        print(message)
        
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            if let userDictionary = snapshot.value as? NSDictionary {
                
                if let email = userDictionary["email"] as? String {
                    
                    let user = User()
                    user.email = email
                    user.uid = snapshot.key
                    
                    self.users.append(user)
                    self.tableView.reloadData()
                    
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        if let fromEmail = Auth.auth().currentUser?.email {
           
            let snapDictionary = ["from" : fromEmail, "imageName" : imageName, "imageURL" : imageURL, "message" : message]
            Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snapDictionary)
            
            navigationController?.popToRootViewController(animated: true)
            
            }
        }

}

class User {
    var email = ""
    var uid = ""
}
