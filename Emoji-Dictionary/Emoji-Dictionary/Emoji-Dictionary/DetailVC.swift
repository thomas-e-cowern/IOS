//
//  DetailVC.swift
//  Emoji-Dictionary
//
//  Created by Thomas Cowern New on 8/21/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var emojiLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var birthLabel: UILabel!
    
    @IBOutlet weak var emojiDefLabel: UILabel!
    
    var emoji = Emoji()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emojiLabel.text = emoji.emoji
        categoryLabel.text = "Category: \(emoji.category)"
        birthLabel.text = "Release Date: \(emoji.releaseDate)"
        emojiDefLabel.text = emoji.definition

    }

}
