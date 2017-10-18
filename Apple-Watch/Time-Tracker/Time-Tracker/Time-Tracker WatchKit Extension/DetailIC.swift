    //
    //  DetailIC.swift
    //  Time-Tracker WatchKit Extension
    //
    //  Created by Thomas Cowern New on 10/16/17.
    //  Copyright © 2017 vetDevHouse. All rights reserved.
    //
    
    import WatchKit
    import Foundation
    
    
    class DetailIC: WKInterfaceController {
        
        @IBOutlet var clockInDate: WKInterfaceLabel!
        
        @IBOutlet var clockOutDate: WKInterfaceLabel!
        
        override func awake(withContext context: Any?) {
            super.awake(withContext: context)
            
            // Configure interface objects here.
            if let dates = context as? [Date] {
                
                let clockIn = dates[0]
                let clockOut = dates[1]
                
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d h:mm a"
                
                clockInDate.setText(formatter.string(from: clockIn))
                clockOutDate.setText(formatter.string(from: clockOut))
            }
        }
        
        
        
    }
