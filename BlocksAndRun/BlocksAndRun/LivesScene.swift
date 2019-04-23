//
//  LivesScene.swift
//  BlocksAndRun
//
//  Created by Piumi on 14/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import GameplayKit

class LivesScene: SKScene , SKPhysicsContactDelegate {
    
    
    var backgroundSegment1: SKSpriteNode!
    var backgroundSegment2: SKSpriteNode!
    var heart1: SKSpriteNode!
    var heart2: SKSpriteNode!
    var coin: SKSpriteNode!
    var fb: SKSpriteNode!
    
    
    /*
     
     Function: didMove
     Parameters: SKView
     
     Purpose: This function will run as soon as the screen loads-up
     creates all elements of the scene
     
     "CGPoint" method is use for positioning all the elements inside od the view
     
     **Important note for developpers**
     Developers can user a image instead of using a color. to do that remove nil form "texture" and
     add SKTexture textureWithImage:[UIImage imageNamed:"imagename.png"]
     
     */
  
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(color: UIColor(red: 255.00/255.0, green: 182.00/255.0, blue: 193.00/255.0, alpha: 5.0), size: CGSize(width: 700, height: 700))
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        
        backgroundSegment1 = SKSpriteNode(color: UIColor(red: 219.0/255.0, green: 112.0/255.0, blue: 147.0/255.0, alpha: 5.0), size: CGSize(width: 720, height: 250))
        backgroundSegment1.position = CGPoint(x:760, y: 1300)
        //self.isUserInteractionEnabled = true
        addChild(backgroundSegment1)
        
        heart1 = SKSpriteNode(imageNamed: "heart1")
        heart1.size = CGSize(width: 200, height: 200)
        heart1.position = CGPoint(x:560, y: 1280)
       // self.isUserInteractionEnabled = true
        addChild(heart1)
        
        coin = SKSpriteNode(imageNamed: "coin")
        coin.size = CGSize(width: 100, height: 100)
        coin.position = CGPoint(x:1100, y: 1270)
        // self.isUserInteractionEnabled = true
        addChild(coin)
        
        let lives1 = SKLabelNode(text: "Buy lives")
        lives1.name = "tapToStartLabel"
        lives1.position = CGPoint(x: 860, y: 1280)
        lives1.fontColor = UIColor.white
        lives1.fontSize = 60
        self.addChild(lives1)
        
        
        backgroundSegment2 = SKSpriteNode(color: UIColor(red: 219.0/255.0, green: 112.0/255.0, blue: 147.0/255.0, alpha: 5.0), size: CGSize(width: 720, height: 250))
        backgroundSegment2.position = CGPoint(x:760, y: 900)
        self.isUserInteractionEnabled = true
        addChild(backgroundSegment2)
        
        heart2 = SKSpriteNode(imageNamed: "heart2")
        heart2.size = CGSize(width: 200, height: 200)
        heart2.position = CGPoint(x:560, y: 900)
        addChild(heart2)
        
        fb = SKSpriteNode(imageNamed: "fb")
        fb.size = CGSize(width: 100, height: 100)
        fb.position = CGPoint(x:1100, y: 910)
        // self.isUserInteractionEnabled = true
        addChild(fb)
        
        let lives2 = SKLabelNode(text: "Ask lives")
        lives2.name = "tapToStartLabel"
        lives2.position = CGPoint(x: 860, y: 900)
        lives2.fontColor = UIColor.white
        lives2.fontSize = 60
        self.addChild(lives2)
        
        
        
       
    }
}
