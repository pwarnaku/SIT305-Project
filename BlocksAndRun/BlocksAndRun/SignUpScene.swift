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
    var textUserName:UITextField! = nil
    var textPassword:UITextField! = nil
    var textRePassword:UITextField! = nil
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
        textUserName = UITextField(frame: textNameFrame)
        textUserName.backgroundColor = UIColor.white
        textUserName.placeholder = "Enter Your User Name"
        self.view!.addSubview(textUserName)
        
        let textPasswordFrame = CGRect(origin: .init(x: 60.00, y: 400.00), size: CGSize( width: 300,height: 50))
        textPassword = UITextField(frame: textPasswordFrame)
        textPassword.backgroundColor = UIColor.white
        textPassword.placeholder = "Enter Your Password"
        textPassword.isSecureTextEntry = true
        self.view!.addSubview(textPassword)
        
        let textRePasswordFrame = CGRect(origin: .init(x: 60.00, y: 500.00), size: CGSize( width: 300,height: 50))
        textRePassword = UITextField(frame: textRePasswordFrame)
        textRePassword.backgroundColor = UIColor.white
        textRePassword.placeholder = "Re Enter Your Password"
        textRePassword.isSecureTextEntry = true
        self.view!.addSubview(textRePassword)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let skView = self.view as! SKView
        skView.isMultipleTouchEnabled = false
        
        let touch = touches.first
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "btnSignUp" {
                
                let alert = UIAlertController(title: "Alert", message: "Registration is completed", preferredStyle: UIAlertController.Style.alert);
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okAction)
                if let vc = self.scene?.view?.window?.rootViewController{
                    vc.present(alert, animated:true, completion: nil)
                }
                
                self.textUserName.removeFromSuperview()
                self.textPassword.removeFromSuperview()
                self.textRePassword.removeFromSuperview()
                let scene = WelcomePlayerScene(size: CGSize(width: 1536, height: 2048))
                scene.scaleMode = .aspectFill
                
                skView.presentScene(scene)
            }
        }
    
    }
    
    /*
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            let touch = touches.first
            if let location = touch?.location(in: self){
                let nodesArray = self.nodes(at: location)
                
                if nodesArray.first?.name == "signUpButton" {
                    
 
                    UserDefaults.standard.set(textUserName, forKey:"userName");
                    UserDefaults.standard.set(textPassword, forKey:"userEmail");
                    UserDefaults.standard.set(textRePassword, forKey:"userPassword");
                    UserDefaults.standard.synchronize();
 

                    
 
                
                    let alert = UIAlertController(title: "Alert", message: "Registration is completed", preferredStyle: UIAlertController.Style.alert);
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                    alert.addAction(okAction)
                    if let vc = self.scene?.view?.window?.rootViewController{
                        vc.present(alert, animated:true, completion: nil)
                    }
 
                    
                    let skView = self.view as! SKView
                    skView.isMultipleTouchEnabled = false
                    
                    let scene = WelcomePlayerScene (size: CGSize(width: 1536, height: 2048))
                    scene.scaleMode = .aspectFill
                    
                    skView.presentScene(scene)
                    
                    //self.inputViewController?.presentedViewController(alert, animated: true, completion: nil);
                    
                    
                }
                
            }
            
        }
        
     
    */

        
        
        
        /*
        func userNameValidate(_ textfield: UITextField){
            if textfield == textUserName {
                let nameRegex = "[A-Z0-9a-z]"
                let nameTest = NSPredicate(format: "SELF MATCHES /@", nameRegex)
                let result = nameRegex.evaluate(with:textfield.text)
                
            }
        }
         
         */

    }
    

    

