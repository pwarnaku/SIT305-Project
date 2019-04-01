//
//  GameViewController.swift
//  BlocksAndRun
//
//  Created by Piumi on 25/3/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the view
        
        
        let skView = self.view as! SKView
        skView.isMultipleTouchEnabled = false
        //   skView.showsFPS = true
        // skView.showsNodeCount = true
        
        //create andconfigure the scene
        scene = GameScene(size: CGSize(width: 1536, height: 2048)) // can scale to any device [piumi]
        //skView.ignoresSiblingOrder = true
        
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

