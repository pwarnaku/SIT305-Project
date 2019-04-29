//
//  SignUpScene.swift
//  BlocksAndRun
//
//  Created by Sachin Kanishka on 16/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import SpriteKit
import GameplayKit

class SignUpScene: SKScene {

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
        
        //sign up button
        let signUpButtonTexture = SKTexture(imageNamed: "signup")
        signUpButton = SKSpriteNode(texture: signUpButtonTexture , size: CGSize(width: 300, height: 75))
        signUpButton.position = CGPoint(x: self.size.width/2, y: 500)
        signUpButton.name = "btnSignUp"
        signUpButton.zPosition = 1
        self.addChild(signUpButton)
        
        //text fields
        let textNameFrame = CGRect(origin: .init(x: 60.00, y: 300.00), size: CGSize( width: 300,height: 50))
        let textUserName = UITextField(frame: textNameFrame)
        textUserName.backgroundColor = UIColor.white
        textUserName.placeholder = "Enter Your User Name"
        self.view!.addSubview(textUserName)
        
        let textPasswordFrame = CGRect(origin: .init(x: 60.00, y: 400.00), size: CGSize( width: 300,height: 50))
        let textPassword = UITextField(frame: textPasswordFrame)
        textPassword.backgroundColor = UIColor.white
        textPassword.placeholder = "Enter Your Password"
        textPassword.isSecureTextEntry = true
        self.view!.addSubview(textPassword)
        
        let textRePasswordFrame = CGRect(origin: .init(x: 60.00, y: 500.00), size: CGSize( width: 300,height: 50))
        let textRePassword = UITextField(frame: textRePasswordFrame)
        textRePassword.backgroundColor = UIColor.white
        textRePassword.placeholder = "Re Enter Your Password"
        textRePassword.isSecureTextEntry = true
        self.view!.addSubview(textRePassword)
        
        
        
    }
    

    
}
