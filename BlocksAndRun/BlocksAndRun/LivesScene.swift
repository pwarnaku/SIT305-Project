//
//  LivesScene.swift
//  BlocksAndRun
//
//  Created by Piumi on 14/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import GameplayKit
import Social


class LivesScene: SKScene  {
    
    
    var backgroundSegment1: SKSpriteNode!
    var backgroundSegment2: SKSpriteNode!
    var heart1: SKSpriteNode!
    var heart2: SKSpriteNode!
    var coin: SKSpriteNode!
    var fb: SKSpriteNode!
    
    var cancelButton: SKNode!
    
    
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
        
        createCancelButton()
        
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
        addChild(fb)
        
        let lives2 = SKLabelNode(text: "Ask lives")
        lives2.name = "tapToStartLabel"
        lives2.position = CGPoint(x: 860, y: 900)
        lives2.fontColor = UIColor.white
        lives2.fontSize = 60
        self.addChild(lives2)
        
        
        
       
    }
    
    /*
     
     Function: createCancelButton
     
     Purpose: This function takesback to the game
     
     ** Important note for developers**
     
     You basically need to create an SKNode of some sort which will draw your button and then check to see if touches registered in your scene are within that node's bounds.
     
     This function is called in gamescene.swift file under didMove function.
     
     */
    
    func createCancelButton(){
        
        // Create a simple red rectangle that's 100x44
        let CancelButtonTexture = SKTexture(imageNamed: "close")
        cancelButton = SKSpriteNode(texture: CancelButtonTexture , size: CGSize(width: 100, height: 100))
        // Put it in the center of the scene
        cancelButton.position = CGPoint(x: 1000, y: 1800)
        cancelButton.zPosition = 1
        
        self.addChild(cancelButton)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.location(in: self)
            // Check if the location of the touch is within the button's bounds
            if cancelButton.contains(location) {
                print("tapped!")
                
                // createLivesWindow()
                let skView = self.view as! SKView
                skView.isMultipleTouchEnabled = false
                
                let scene = GameScene(size: CGSize(width: 1536, height: 2048))
                scene.scaleMode = .aspectFill
                
                skView.presentScene(scene)
                
                
                
                
            }
        }
    }
}
