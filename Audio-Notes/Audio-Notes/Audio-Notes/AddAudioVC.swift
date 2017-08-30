//
//  AddAudioVC.swift
//  Audio-Notes
//
//  Created by Thomas Cowern New on 8/29/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import UIKit
import AVFoundation

class AddAudioVC: UIViewController {
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBAction func recordTapped(_ sender: Any) {
        print("Record tapped")
      
        if let audioRecorder = self.audioRecorder {
            
            if audioRecorder.isRecording {
                audioRecorder.stop()
                recordButton.setTitle("Record", for: .normal)
                playButton.isEnabled = true
                textField.isEnabled = true
                addButton.isEnabled = true
            } else {
                audioRecorder.record()
                recordButton.setTitle("Stop", for: .normal)
                playButton.isEnabled = false
                textField.isEnabled = false
                addButton.isEnabled = false
            }
        }
    }
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBAction func playTapped(_ sender: Any) {
        print("Play tapped")
        
        if let audioURL = self.audioURL {
        audioPlayer = try? AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.play()
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addTapped(_ sender: Any) {
        print("Add tapped")
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let sound = Sound(entity: Sound.entity(), insertInto: context)
            sound.name = textField.text
            if let audioURL = self.audioURL {
                sound.audioData = try? Data(contentsOf: audioURL)
                try? context.save()
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating audio session
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try? session.overrideOutputAudioPort(.speaker)
        try? session.setActive(true)
        
        // Creating URL to save the audio
        if let basePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let pathComponents = [basePath, "audio.m4a"]
            if let audioURL = NSURL.fileURL(withPathComponents: pathComponents) {
                
                // Creating settings
                
                self.audioURL = audioURL
                var settings : [String:Any] = [:]
                settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
                settings[AVSampleRateKey] = 44100.0
                settings[AVNumberOfChannelsKey] = 2
                
                // Creating the audio recorder
                audioRecorder = try? AVAudioRecorder(url: audioURL, settings: settings)
                audioRecorder?.prepareToRecord()
                
            }
        }
        
        playButton.isEnabled = false
        textField.isEnabled = false
        addButton.isEnabled = false
    }
}
