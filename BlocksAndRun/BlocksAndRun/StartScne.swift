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
    
    //main animation
    var mainRunningAnimation: SKSpriteNode!
    
    var cloudGenerator: CloudsGenarator!
    var movingBridge: MovingBridge!
    
    //Audio clips
    let backgroundSound = SKAudioNode(fileNamed: "backgroundMusic.mp3")
   
    //arrays
    var textureAtlas = SKTextureAtlas()
    var textureArray = [SKTexture]()
    
    //textfields
    var userNameTextField:UITextField! = nil    
    
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
        
        //adds background music
         self.addChild(backgroundSound)
        
        textureAtlas = SKTextureAtlas(named: "running")
        
        for i in 1...textureAtlas.textureNames.count{
            
            let imageName = "run\(i)"
            textureArray.append(SKTexture(imageNamed: imageName))
        }
        
        mainRunningAnimation = SKSpriteNode(imageNamed: textureAtlas.textureNames[0] as! String)
        mainRunningAnimation.size = CGSize(width: 500, height: 800)
        mainRunningAnimation.position = CGPoint(x: self.size.width/2, y: 770)
        mainRunningAnimation.zPosition = 2
        
        self.addChild(mainRunningAnimation)
        
        
        mainRunningAnimation.run(SKAction.repeatForever(SKAction.animate(with: textureArray, timePerFrame: 0.09)))
        
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        // add cloud generator
        cloudGenerator = CloudsGenarator(color: UIColor.clear, size: view.frame.size)
        cloudGenerator.position = CGPoint(x:900, y: 1800)
        cloudGenerator.zPosition = 0
        addChild(cloudGenerator)
        cloudGenerator.populate(num: 10)
        cloudGenerator.stratGeneratingwithSpawnTime(seconds: 1)
        
        movingBridge = MovingBridge(size: CGSize(width: self.size.width, height: 620))
        movingBridge.position = CGPoint(x: 0, y: 300)
        movingBridge.zPosition = 10
        self.addChild(movingBridge)
        movingBridge.start()
        
       // UserDefaults.standard.set("Default", forKey:"userName");
       // UserDefaults.standard.set("", forKey:"highScore");
        
        
        /*
         This label is allow user to tap on the screen to start the game
         this funtion named the label again to access the node in start method
         
         */
        
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
    
    
        addSnowEmitter()
    
        
    }
    /*
     
     Function: addSnowEmitter
     
     Purpose: This function uses swift snow emitter. as this is the first screen of the app, i use snow emitter
     to decorate the user interface
     
     **Important note for developpers**
     
     Developpers can use different emiters as they want. in order to add an emitter, go to create newfile ->
     choose "Spritekit prcatice file" and then choose the efect you want
     
    */
    
    func addSnowEmitter(){
        let snowEmitter = SKEmitterNode(fileNamed: "Snow")!
        snowEmitter.position = CGPoint(x: size.width/2 , y: 1800)
        addChild(snowEmitter)
    }
    
    /*
     
     Function: touchesBegan
     
     Purpose : This is the launching screen of the game. after upse taps on the screen
     , it will open the second screen ( GameScene) andthe game will start, all the background images will uploaded.
     
     **Important note for developpers**
     
     If developpers want to add animation parts of any background elements make sure those funtions
     are called here
     
     
     */
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
      
        
        let alert = UIAlertController(title: "User Login", message: "What is your user name? ", preferredStyle: UIAlertController.Style.alert);
        
        alert.addTextField { (textUserName) in
            self.userNameTextField = textUserName
            self.userNameTextField!.placeholder = "Your Username here"
        }

        let okAction = UIAlertAction(title: "Login", style: UIAlertAction.Style.default) { (UIAlertAction) in
            
                if let userName = self.userNameTextField!.text {
                    print(" Username = \(String(describing: userName))")
                    UserDefaults.standard.set(self.userNameTextField.text, forKey:"userName");
                    print("Input = \(UserDefaults.standard.set(self.userNameTextField.text, forKey:"userName"))")
                    
                    
                    let skView = self.view as! SKView
                    skView.isMultipleTouchEnabled = false
                    
                    let scene = WelcomePlayerScene(size: CGSize(width: 1536, height: 2048))
                    scene.scaleMode = .aspectFill
                    
                    skView.presentScene(scene)
                }
                else {
                    print ("No Username added")
                }
            }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)


        if let vc = self.scene?.view?.window?.rootViewController{
            vc.present(alert, animated:true, completion: nil)
        }
        
    }
   
    
}


