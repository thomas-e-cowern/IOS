//
//  InterfaceController.swift
//  Time-Tracker WatchKit Extension
//
//  Created by Thomas Cowern New on 10/4/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    
    @IBOutlet var button: WKInterfaceButton!
    @IBOutlet var middleLabel: WKInterfaceLabel!
    @IBOutlet var topLabel: WKInterfaceLabel!
    
    var clockedIn = false
    
    var timer : Timer? = nil
    
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        
    }
    
    override func willActivate() {
        if UserDefaults.standard.value(forKey: "clockedIn") != nil {
            if timer == nil {
                startUpTimer()
            }
            
            clockedIn = true
            
            updateUI(clockedIn: true)
            
        } else {
            clockedIn = false
            updateUI(clockedIn: false)
        }
    }
    
    func updateUI(clockedIn: Bool) {
        if clockedIn {
            topLabel.setHidden(false)
            topLabel.setText("Today: \(totalTimeWorkedAsString())")
            middleLabel.setText("0s")
            button.setTitle("Clock-Out")
            button.setBackgroundColor(UIColor.red)
        } else {
            topLabel.setHidden(true)
            middleLabel.setText("Today\n\(totalTimeWorkedAsString())")
            button.setTitle("Clock-In")
            button.setBackgroundColor(UIColor.green)
        }
    }
    
    @IBAction func clockInOutTapped() {
        if clockedIn {
            clockOut()
        } else {
            clockIn()
        }
        updateUI(clockedIn: clockedIn)
    }
    
    func startUpTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if let clockedInDate = UserDefaults.standard.value(forKey: "clockedIn") as? Date {
                let timeInterval = Int(Date().timeIntervalSince(clockedInDate))
                
                let hours = timeInterval / 3600
                //                print("h:\(hours)")
                let minutes = (timeInterval % 3600) / 60
                //                print("m:\(minutes)")
                let seconds = timeInterval % 60
                //                print("s:\(seconds)")
                
                var currentClockedInString = ""
                
                if hours != 0 {
                    currentClockedInString += "\(hours)h "
                }
                if minutes != 0 || hours != 0{
                    currentClockedInString += "\(minutes)m "
                }
                currentClockedInString += "\(seconds)s"
                
                self.middleLabel.setText("\(currentClockedInString)")
                
                self.topLabel.setText("Today: \(self.totalTimeWorkedAsString())")
            }
        }
    }
    
    func clockIn() {
        clockedIn = true
        UserDefaults.standard.set(Date(), forKey: "clockedIn")
        UserDefaults.standard.synchronize()
        
        startUpTimer()
        
    }
    
    func clockOut() {
        clockedIn = false
        
        timer?.invalidate()
        timer = nil
        
        if let clockedInDate = UserDefaults.standard.value(forKey: "clockedIn") as? Date {
            //Adding clocked in time to the clockins array
            if var clockIns = UserDefaults.standard.array(forKey: "clockIns") as? [Date] {
                clockIns.insert(clockedInDate, at: 0)
                UserDefaults.standard.set(clockIns, forKey: "clockIns")
                //                print(clockins)
            } else {
                UserDefaults.standard.set([clockedInDate], forKey: "clockIns")
            }
            //adding the clockout time to clockouts array
            if var clockOuts = UserDefaults.standard.array(forKey: "clockOuts") as? [Date] {
                clockOuts.insert(Date(), at: 0)
                UserDefaults.standard.set(clockOuts, forKey: "clockOuts")
                //                print("Clockouts: \(clockouts)")
            } else {
                UserDefaults.standard.set([Date()], forKey: "clockOuts")
            }
            UserDefaults.standard.set(nil, forKey: "clockedIn")
        }
        UserDefaults.standard.synchronize()
        
    }
    
    func totalClockedTime() -> Int {
        
        if var clockIns = UserDefaults.standard.array(forKey: "clockIns") as? [Date] {
            if var clockOuts = UserDefaults.standard.array(forKey: "clockOuts") as? [Date] {
                
                var seconds = 0
                for index in 0..<clockIns.count {
                    
                    let currentSeconds = Int(clockOuts[index].timeIntervalSince(clockIns[index]))
                    
                    seconds += currentSeconds
                    
                }
//                print("cs;\(seconds)")
                return seconds
            }
        }
        return 0
    }
    
    func totalTimeWorkedAsString () -> String {
        
        var currentClockedinSeconds = 0
        
        if let clockedInDate = UserDefaults.standard.value(forKey: "clockedIn") as? Date {
            currentClockedinSeconds = Int(Date().timeIntervalSince(clockedInDate))
        }
        let totalTimeInterval = currentClockedinSeconds + self.totalClockedTime()
//        print("tti:\(totalTimeInterval)")
        let totalHours = totalTimeInterval / 3600
        let totalMinutes = (totalTimeInterval % 3600) / 60
        
        return "\(totalHours)h \(totalMinutes)m"
    }
    
    @IBAction func resetAllTapped() {
        UserDefaults.standard.set(nil, forKey: "clockedIn")
        UserDefaults.standard.set(nil, forKey: "clockOuts")
        UserDefaults.standard.set(nil, forKey: "clockIns")
        
        UserDefaults.standard.synchronize()
        
        updateUI(clockedIn: false)
    }
    
    @IBAction func historyPressed() {
        pushController(withName: "timeTableController", context: nil)
    }
    
    
}
