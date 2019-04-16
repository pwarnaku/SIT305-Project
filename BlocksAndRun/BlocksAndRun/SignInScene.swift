//
//  SignInScene.swift
//  BlocksAndRun
//
//  Created by Sachin Kanishka on 16/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class SignInScene: SKScene {
    
     var signInButton:SKSpriteNode!
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
        
        //text fields
        let textUserName = UITextField(frame: CGRect(x: self.frame.width/2, y: self.frame.size.height - 60, width: 600,height: 100))
        textUserName.backgroundColor = UIColor.white
        textUserName.placeholder = "User Name"
       // self.view!.addSubview(textUserName)
        
        //sign in button
        let signInButtonTexture = SKTexture(imageNamed: "signin")
        signInButton = SKSpriteNode(texture: signInButtonTexture , size: CGSize(width: 300, height: 75))
        signInButton.position = CGPoint(x: self.size.width/2, y: 500)
        signInButton.name = "btnSignIn"
        signInButton.zPosition = 1
        self.addChild(signInButton)
        
        
        
        
       let skView = self.view as! SKView
       skView.isMultipleTouchEnabled = false
       skView.addSubview(textUserName)
       //skView.presentScene(SKScene(size: frame.size))
        
        
        
        
        
        
        
        
        
        
    }
    

}
