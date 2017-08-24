//
//  EmojiTVC.swift
//  Emoji-Dictionary
//
//  Created by Thomas Cowern New on 8/21/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import UIKit

class EmojiTVC: UITableViewController {
    
//    ["😀", "😇", "😡", "🤡", "🍎", "🥑"]
    
    var emojis : [Emoji] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        emojis = createEmojis()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return emojis.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath)

        let emoji = emojis[indexPath.row]
        
        cell.textLabel?.text = "\(emoji.emoji) - \(emoji.category)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let emoji = emojis[indexPath.row]
        
        performSegue(withIdentifier: "emojiSegue", sender: emoji)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let emojiDetailVC = segue.destination as! DetailVC
        
        emojiDetailVC.emoji = sender as! Emoji
        
    }
    
    func createEmojis() -> [Emoji] {
        let smiley = Emoji()
        smiley.emoji = "😀"
        smiley.definition = "A happy smiling face"
        smiley.category = "faces"
        smiley.releaseDate = 2010
        
        let avo = Emoji()
        avo.emoji = "🥑"
        avo.definition = "A nice green avacado"
        avo.category = "Food"
        avo.releaseDate = 2011
        
        return [smiley, avo]
    }

}
