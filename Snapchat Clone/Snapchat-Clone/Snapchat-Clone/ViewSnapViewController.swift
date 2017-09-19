//
//  ViewSnapViewController.swift
//  Snapchat-Clone
//
//  Created by Thomas Cowern New on 9/15/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage
import FirebaseAuth
import FirebaseStorage


class ViewSnapViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var messageView: UILabel!
    
    var snapshot : DataSnapshot?
    
    var imageName = ""
    
    var snapID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let snapshot = snapshot {
            if let snapDictionary = snapshot.value as? NSDictionary {
                
                if let imageName = snapDictionary["imageName"] as? String {
                    if let imageURL = snapDictionary["imageURL"] as? String {
                        if let message = snapDictionary["message"] as? String {
                            messageView.text = message
                            
                            if let url = URL(string: imageURL) {
                                imageView.sd_setImage(with: url, completed: nil)
                                
                            }
                            
                            self.imageName = imageName
                            
                            snapID = snapshot.key
                        }
                    }
                }
                
            }
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool){
        
        print("Hit Delete")
        if let uid = Auth.auth().currentUser?.uid {
            Database.database().reference().child("users").child(uid).child("snaps").child(snapID).removeValue()
            
            Storage.storage().reference().child("images").child(imageName).delete(completion: nil)
        }
    }
    
    
}
