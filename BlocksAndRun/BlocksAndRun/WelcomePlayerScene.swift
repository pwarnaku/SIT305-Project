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
    
    var cloudGenerator:CloudsGenarator!
    var userNameTextField:UITextField! = nil
    
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
        
        //Blocks and Run name label
        let welcomeLabel = SKLabelNode(text: "Welcome \(getData()) !!")
        welcomeLabel.name = "welcomeLabel"
        welcomeLabel.position = CGPoint(x: self.size.width/2, y: 1100)
        welcomeLabel.fontColor = UIColor.white
        welcomeLabel.fontSize = 100
        self.addChild(welcomeLabel)
        
       // let userNameStored = UserDefaults.standard.string(forKey: "userName");
        //UserDefaults.standard.set(true, forKey:"isUserLoggedIn");
       // UserDefaults.standard.synchronize();
       
        /*
        //Blocks and Run name label
        let welcomeLabel = SKLabelNode(text: "Welcome \(getData())")
        welcomeLabel.name = "welcomeLabel"
        welcomeLabel.position = CGPoint(x: self.size.width/2, y: 1100)
        welcomeLabel.fontColor = UIColor.white
        welcomeLabel.fontSize = 100
      //  self.addChild(welcomeLabel)

        */
       
        
        /*
        let ac = UIAlertController(title: "Enter Username", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self, ac] _ in
            let playName = ac.textFields![0]
            
        })
        
        ac.present(ac, animated: true, completion: nil)
        
 
        
        let alert = UIAlertController(title: "Alert", message: "Registration is completed", preferredStyle: UIAlertController.Style.alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        if let vc = self.scene?.view?.window?.rootViewController{
            vc.present(alert, animated:true, completion: nil)
        }
        
  */
        
    }
    
    func getData() -> String {
        return UserDefaults.standard.string(forKey: "userName")!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let skView = self.view as! SKView
        skView.isMultipleTouchEnabled = false
/*
        let alert = UIAlertController(title: "User Login", message: "", preferredStyle: UIAlertController.Style.alert);
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        
        alert.addTextField { (textUserName) in
            self.userNameTextField = textUserName
            self.userNameTextField!.placeholder = "Your Username here"
        }
        if let vc = self.scene?.view?.window?.rootViewController{
            vc.present(alert, animated:true, completion: nil)
        }
        */ 
        let scene = GameScene (size: CGSize(width: 1536, height: 2048))
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
        
        
    }
    

}
