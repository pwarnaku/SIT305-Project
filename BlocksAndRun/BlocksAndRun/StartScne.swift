//
//  StartScne.swift
//  BlocksAndRun
//
//  Created by Piumi on 6/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import GameplayKit

class StartScene: SKScene , SKPhysicsContactDelegate {
   
    var cloudGenerator: CloudsGenarator!
    
    
    /*
     
     Function: didMove
     Parameters: SKView
     
     What does: This function will run as soon as the screen loads-up
     creates all elements
     
     
     */
    override func didMove(to view: SKView) {
        
        /*
         Gets the center point for the position and makes the bridge
         */
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        
        
        // add cloud generator
        cloudGenerator = CloudsGenarator(color: UIColor.clear, size: view.frame.size)
        cloudGenerator.position = CGPoint(x:800, y: 1100)
        cloudGenerator.zPosition = 0
        addChild(cloudGenerator)
        cloudGenerator.populate(num: 2)
        cloudGenerator.stratGeneratingwithSpawnTime(seconds: 5)
        
        
        
        
        /*
         This label is allow user to tap on the screen to start the game
         this funtion named the label again to access the node in start method
         
         */
        
        let nameOfTheGameLabel = SKLabelNode(text: "Blocks and Run")
        nameOfTheGameLabel.name = "tapToStartLabel"
        nameOfTheGameLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        nameOfTheGameLabel.fontColor = UIColor.white
        nameOfTheGameLabel.fontSize = 100
        // tapToStartLabel.zPosition = 1
        self.addChild(nameOfTheGameLabel)
        
       
        
    }
    /*
     Funtion: touchesBegan
     
     What does: This is the launching screen of the game. after upse taps on the screen
     , it will open the second screen ( GameScene) andthe game will start, all the background images will uploaded.
     
     ** If developpers want to add animation parts of any background elements make sure those funtions
     are called here
     
     
     */
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    
        let skView = self.view as! SKView
        skView.isMultipleTouchEnabled = false
        
        let scene = GameScene(size: CGSize(width: 1536, height: 2048))
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
        
        
}

}

//}
