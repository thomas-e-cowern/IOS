//
//  ViewController.swift
//  ARTesting
//
//  Created by Thomas Cowern New on 9/5/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        for node in sceneView.scene.rootNode.childNodes {
            let moveShip = SCNAction.moveBy(x: 0, y: 0.5, z: -0.5, duration: 1)
            
            let fadeOutShip = SCNAction.fadeOpacity(to: 0.3, duration: 1)
            
            let fadeInShip = SCNAction.fadeOpacity(to: 1.0, duration: 1)
            
            let sequenceAction = SCNAction.sequence([moveShip, fadeOutShip, fadeInShip])
            
            let repeatAction = SCNAction.repeatForever(sequenceAction)
            
            node.runAction(repeatAction)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
}
