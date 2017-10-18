//
//  ViewController.swift
//  DetectThePic
//
//  Created by Thomas Cowern New on 9/5/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let resnetModel = Resnet50()
    var imagePicker = UIImagePickerController()
    var observations : [VNClassificationObservation] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    func processPic(image: UIImage) {
        
        if let model = try? VNCoreMLModel(for: resnetModel.model) {
            let request = VNCoreMLRequest(model: model, completionHandler: { (request, error) in
                if let results = request.results as? [VNClassificationObservation] {
                    
                    self.observations = results
                    
                    self.tableView.reloadData()
                    //                    for result in results {
                    //                        print("ID: \(result.identifier) Confidence: \(result.confidence)")
                    //                    }
                }
            })
            
            if let imageData = UIImageJPEGRepresentation(image, 1.0) {
                
                let handler = VNImageRequestHandler(data: imageData, options: [:])
                try? handler.perform([request])
                
            }
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            processPic(image: image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return observations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? CoreMLTableViewCell {
            
            let observation = observations[indexPath.row]
            
            cell.theSmallLabel.text = "ID: \(observation.identifier) Confidence: \(observation.confidence * 100.0)%"
            
            return cell
        }
        return UITableViewCell()
    }
}

