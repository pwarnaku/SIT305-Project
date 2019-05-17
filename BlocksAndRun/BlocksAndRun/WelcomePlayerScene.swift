//
//  WelcomePlayerScene.swift
//  BlocksAndRun
//
//  Created by Sachin Kanishka on 12/5/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import SpriteKit
import GameplayKit


class WelcomePlayerScene: SKScene {
    
    var playButton: SKSpriteNode!
    
    var cloudGenerator:CloudsGenarator!
    var userNameTextField:UITextField! = nil
    
    override func didMove(to view: SKView) {
        
        createPlayButton()
        
        //background image
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        //Blocks and Run name label
        if let nodeToMask = SKEmitterNode(fileNamed: "MyParticlekoji") {
            
            backgroundColor = UIColor.blue
            let cropNode = SKCropNode()
            cropNode.position = CGPoint(x: self.size.width/2, y: 1700)
            
            let mask = SKLabelNode(fontNamed: "GillSans-BoldItalic")
            mask.text = "Run"
            mask.fontColor = UIColor.green
            mask.fontSize = 180
            
            cropNode.maskNode = mask
            cropNode.zPosition = 6
            
            nodeToMask.position = CGPoint(x: 0, y: 0)
            nodeToMask.name = "character"
            cropNode.addChild(nodeToMask)
            
            addChild(cropNode)
        }
        
        //add cloud generator
        cloudGenerator = CloudsGenarator(color: UIColor.clear, size: view.frame.size)
        cloudGenerator.position = CGPoint(x:900, y: 1800)
        cloudGenerator.zPosition = 0
        addChild(cloudGenerator)
        cloudGenerator.populate(num: 10)
        cloudGenerator.stratGeneratingwithSpawnTime(seconds: 1)
        
        //Blocks and Run name label
        let welcomeLabel = SKLabelNode(text: "Welcome \(getData()) !!")
        welcomeLabel.name = "welcomeLabel"
        welcomeLabel.position = CGPoint(x: self.size.width/2, y: 1300)
        welcomeLabel.fontName = "Marion-Italic"
        welcomeLabel.fontColor = UIColor.white
         welcomeLabel.fontSize = 80
        self.addChild(welcomeLabel)
        
       // let userNameStored = UserDefaults.standard.string(forKey: "userName");
        //UserDefaults.standard.set(true, forKey:"isUserLoggedIn");
       // UserDefaults.standard.synchronize();
       
  
        
    }
    /*
     
     Function: scalingAnimation
     
     Purpose: This function is to animate nodes. this will scale up and Wait for 2 seconds before
     repeating the actionown an node. Form a sequence with the scale actions, as well as the wait action.
     return the scalling sequence
     
     ** Important note for developers**
     
     if you want to apply the animation use nodename.run(action:scalingAnimation())
     
     */
    
    
    func scalingAnimation() -> SKAction{
        
        
        let scaleUpAction = SKAction.scale(to: 1.5, duration: 0.3)
        let scaleDownAction = SKAction.scale(to: 1, duration: 0.3)
        let waitAction = SKAction.wait(forDuration: 2)
        let scallingSequence = SKAction.sequence([scaleUpAction, scaleDownAction, waitAction])
        return SKAction.repeatForever(scallingSequence)
        
    }
    func createPlayButton(){
        
        let playeButtonTexture = SKTexture(imageNamed: "playButton")
        playButton = SKSpriteNode(texture: playeButtonTexture , size: CGSize(width: 300, height: 300))
        playButton.position = CGPoint(x: self.size.width/2, y: 850)
        playButton.zPosition = 1
        
        self.addChild(playButton)
        playButton.run(scalingAnimation())
        
        
    }
    
    
    func getData() -> String {
        return UserDefaults.standard.string(forKey: "userName")!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.location(in: self)
            // Check if the location of the touch is within the button's bounds
            if playButton.contains(location) {
                print("tapped!")
                let skView = self.view as! SKView
                skView.isMultipleTouchEnabled = false
                
                let scene = GameScene(size: CGSize(width: 1536, height: 2048))
                scene.scaleMode = .aspectFill
                
                skView.presentScene(scene)
                
                
            }
            
            
            
        }
        
        
    }
    

}
