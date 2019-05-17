//
//  PlayerSelection.swift
//  BlocksAndRun
//
//  Created by Piumi on 28/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import GameplayKit


class PlayerSelection: SKScene  {
  
  //  weak var scrollView: CustomScrollView!
    let moveableNode = SKNode()
    
    var textureAtlas1 = SKTextureAtlas()
    var textureArray1 = [SKTexture]()
    
    var textureAtlas2 = SKTextureAtlas()
    var textureArray2 = [SKTexture]()
    
    var backgroundSegment1: SKShapeNode!
    var backgroundSegment2: SKShapeNode!
    var man1: SKSpriteNode!
    var man2: SKSpriteNode!
    var frame1: SKSpriteNode!
    var underline: SKSpriteNode!
    
    var button1: SKSpriteNode!
    var cancelButton: SKNode!
    var select1Button: SKSpriteNode!
    var select2Button: SKSpriteNode!
    
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
       
        CreateTheBackground()
        CreateplayerSelectionLabel()
        CreateTheUnderline()
        createCancelButton()
        player1SelectionButton()
        player2SelectionButton()
        
        
        backgroundSegment1 = SKShapeNode(rect: CGRect(x: 360, y: 1100, width: 345, height: 500), cornerRadius: 80)
        backgroundSegment1.fillColor = UIColor(red: 92.00/255.0, green: 156.0/255.0, blue: 131.0/255.0, alpha: 5.0)
        addChild(backgroundSegment1)
        
        let frame1Texture = SKTexture(imageNamed: "frame1")
        frame1 = SKSpriteNode(texture: frame1Texture, size: CGSize(width: 220, height: 750))
         frame1.position = CGPoint(x:760, y: 1300)
        frame1.zPosition = 10
        
       // addChild(frame1)
        
        textureAtlas1 = SKTextureAtlas(named: "running")
        
        for i in 1...textureAtlas1.textureNames.count{
            
            let imageName1 = "run\(i)"
            textureArray1.append(SKTexture(imageNamed: imageName1))
        }
        
        man1 = SKSpriteNode(imageNamed: textureAtlas1.textureNames[0] as! String)
        man1.size = CGSize(width: 300, height: 600)
        man1.position = CGPoint(x: 530, y: 1360)
        man1.zPosition = 10
        
        self.addChild(man1)
        
        
        man1.run(SKAction.repeatForever(SKAction.animate(with: textureArray1, timePerFrame: 0.06)))
        
        
        
        backgroundSegment2 = SKShapeNode(rect: CGRect(x: 360, y: 500, width: 345, height: 500), cornerRadius: 80)
        backgroundSegment2.fillColor = UIColor(red: 92.00/255.0, green: 156.0/255.0, blue: 131.0/255.0, alpha: 5.0)
        addChild(backgroundSegment2)
        
        textureAtlas2 = SKTextureAtlas(named: "man2")
        
        for i in 1...textureAtlas2.textureNames.count{
            
            let imageName = "man\(i)"
            textureArray2.append(SKTexture(imageNamed: imageName))
        }
        
        man2 = SKSpriteNode(imageNamed: textureAtlas2.textureNames[0] as! String)
        man2.size = CGSize(width: 300, height: 600)
        man2.position = CGPoint(x: 530, y: 700)
        man2.zPosition = 20
        
        self.addChild(man2)
        
        
        man2.run(SKAction.repeatForever(SKAction.animate(with: textureArray2, timePerFrame: 0.06)))
    }
    
    /*
     
     Function: createTheBackground
     
     Purpose: This function creates the background.
     
     ** Important note for developers**
     
     This function is called in PlayerSelection.swift file under didMove function.
     
     */
    
    func CreateTheBackground(){
        
        let background = SKSpriteNode(color: UIColor(red: 88.00/255.0, green: 101.00/255.0, blue: 100.00/255.0, alpha: 5.0), size: CGSize(width: 700, height: 700))
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
    }
    
    /*
     
     Function: CreateplayerSelectionLabel
     
     Purpose: This function creates the  "Select a player" header
     
     ** Important note for developers**
     This function is called in PlayerSelection.swift file under didMove function
     
     */
    
    func CreateplayerSelectionLabel(){
        
        let payerSelection = SKLabelNode(text: "Select a player")
        payerSelection.name = "playerSelection"
        payerSelection.position = CGPoint(x: self.size.width/2, y: 1795)
        payerSelection.zPosition = 10
        payerSelection.fontName = "SnellRoundhand-Black"
        payerSelection.fontColor = UIColor.white
        payerSelection.fontSize = 100
        
        self.addChild(payerSelection)
        
    }
    
    /*
    Function: CreateTheUnderline
    
    Purpose: This function creates the underline texture under the  "Select a player" header
    
    ** Important note for developers**
    This function is called in PlayerSelection.swift file under didMove function
    
    */
    
    func CreateTheUnderline(){
        
        let underlineTexture = SKTexture(imageNamed: "underline")
        underline = SKSpriteNode(texture: underlineTexture, size: CGSize(width: 700, height:900))
        
        underline.position = CGPoint(x: self.size.width/2, y: 1750)
        underline.zPosition = 20
        self.addChild(underline)
    }
    
    /*
     
     Function: createCancelButton
     
     Purpose: This function takesback to the game
     
     ** Important note for developers**
     
     You basically need to create an SKNode of some sort which will draw your button and then check to see if touches registered in your scene are within that node's bounds.
     
     This function is called in PlayerSelection.swift file under didMove function.
     
     */
    
    func createCancelButton(){
        
        // Create a simple red rectangle that's 100x44
        let CancelButtonTexture = SKTexture(imageNamed: "ok")
        cancelButton = SKSpriteNode(texture: CancelButtonTexture , size: CGSize(width: 100, height: 100))
        // Put it in the center of the scene
        cancelButton.position = CGPoint(x: 1120, y: 1900)
        cancelButton.zPosition = 1
        
        self.addChild(cancelButton)
        
    }
    
    func player1SelectionButton(){
        
        let select1ButtonTexture = SKTexture(imageNamed: "select")
        select1Button = SKSpriteNode(texture: select1ButtonTexture , size: CGSize(width: 200, height: 200))
        // Put it in the center of the scene
        select1Button.position = CGPoint(x: 1000, y: 1350)
        select1Button.zPosition = 1
    
        addChild(select1Button)
        
        
    }
    
    func player2SelectionButton(){
        
        let select1ButtonTexture = SKTexture(imageNamed: "select")
        select2Button = SKSpriteNode(texture: select1ButtonTexture , size: CGSize(width: 200, height: 200))
        // Put it in the center of the scene
        select2Button.position = CGPoint(x: 1000, y: 750)
        select2Button.zPosition = 1
        
        addChild(select2Button)
        
        
    }
    

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.location(in: self)
            
            // Button click event for close button
            if cancelButton.contains(location) {
                print("tapped!")
                
                // createLivesWindow()
                let skView = self.view as! SKView
                skView.isMultipleTouchEnabled = false
                
                let scene = GameScene(size: CGSize(width: 1536, height: 2048))
                scene.scaleMode = .aspectFill
                
                skView.presentScene(scene)
            
            }
            // Button click event for select player 1 button
            if select1Button.contains(location) {
                print("tapped!")
                
               
                let skView = self.view as! SKView
                skView.isMultipleTouchEnabled = false
                
                let scene = GameScene(size: CGSize(width: 1536, height: 2048))
                scene.scaleMode = .aspectFill
                
                skView.presentScene(scene)
                
                
            }
              // Button click event for select player 1 button
            if select2Button.contains(location) {
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