//
//  MenuScene.swift
//  BlocksAndRun
//
//  Created by Sachin Kanishka on 9/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene: SKScene {
    
    var signInButton:SKSpriteNode!
    var signUpButton:SKSpriteNode!
    var cloudGenerator:CloudsGenarator!
    
    override func didMove(to view: SKView) {
        
        //background image
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        //Blocks and Run name label
        let nameOfTheGameLabel = SKLabelNode(text: "Blocks and Run")
        nameOfTheGameLabel.name = "tapToStartLabel"
        nameOfTheGameLabel.position = CGPoint(x: self.size.width/2, y: 1500)
        nameOfTheGameLabel.fontColor = UIColor.white
        nameOfTheGameLabel.fontSize = 100
        self.addChild(nameOfTheGameLabel)
        
        //add cloud generator
        cloudGenerator = CloudsGenarator(color: UIColor.clear, size: view.frame.size)
        cloudGenerator.position = CGPoint(x:900, y: 1800)
        cloudGenerator.zPosition = 0
        addChild(cloudGenerator)
        cloudGenerator.populate(num: 10)
        cloudGenerator.stratGeneratingwithSpawnTime(seconds: 1)
        
        //sign in button
        let signInButtonTexture = SKTexture(imageNamed: "signin")
        signInButton = SKSpriteNode(texture: signInButtonTexture , size: CGSize(width: 600, height: 150))
        signInButton.position = CGPoint(x: self.size.width/2, y: 1100)
        signInButton.name = "btnSignIn"
        signInButton.zPosition = 1
        self.addChild(signInButton)
        
        //sign up button
        let signUpButtonTexture = SKTexture(imageNamed: "signup")
        signUpButton = SKSpriteNode(texture: signUpButtonTexture , size: CGSize(width: 600, height: 150))
        signUpButton.position = CGPoint(x: self.size.width/2, y: 800)
        signUpButton.name = "btnSignUp"
        signUpButton.zPosition = 1
        self.addChild(signUpButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let skView = self.view as! SKView
        skView.isMultipleTouchEnabled = false
    
        let touch = touches.first
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "btnSignIn" {
                let scene = SignInScene(size: CGSize(width: 1536, height: 2048))
                scene.scaleMode = .aspectFill
            
                skView.presentScene(scene)
            }
            
            else if nodesArray.first?.name == "btnSignUp" {
                let scene = SignUpScene(size: CGSize(width: 1536, height: 2048))
                scene.scaleMode = .aspectFill
                
                skView.presentScene(scene)
            }
        }
        
        
    }
    
    

    
    

    
}
