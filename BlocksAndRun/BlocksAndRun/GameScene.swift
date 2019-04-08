//
//  GameScene.swift
//  BlocksAndRun
//
//  Created by Piumi on 25/3/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene , SKPhysicsContactDelegate {
    var movingBridge: MovingBridge!
    var player: Player!
    var blocksGenerator: BlocksGenarator!
    
    var isGameStarted = false
    var isGameOver = false
    
    /*
     
     Function: didMove
     Parameters: SKView
     
     What does: This function will run as soon as the screen loads-up
     creates all elements
     
     
     */
    override func didMove(to view: SKView) {
        
        /*
         Gets the center point for the position and makes the bridge
        */
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        // creates the moving bridge
        movingBridge = MovingBridge(size: CGSize(width: self.size.width, height: 220))
        movingBridge.position = view.center
        movingBridge.zPosition = 1
        self.addChild(movingBridge)
        
        
        // creates the player
        player = Player()
        player.position = CGPoint(x: 350, y: movingBridge.position.y + movingBridge.frame.size.height/2 + player.frame.size.height/2)
        self.addChild(player)
        player.breath() // call the breath animation
        
        // creates the blocks
       
        blocksGenerator = BlocksGenarator(color: UIColor.clear, size: view.frame.size)
        blocksGenerator.position = view.center
        addChild(blocksGenerator)
        
        /*
         This label is allow user to tap on the screen to start the game
         this funtion named the label again to access the node in start method
         
         */
        
        let tapToStartLabel = SKLabelNode(text: "Tap to Start")
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        tapToStartLabel.fontColor = UIColor.white
        tapToStartLabel.fontSize = 100
        self.addChild(tapToStartLabel)
        
       /*
        Add the physics world
        */
        
        physicsWorld.contactDelegate = self
        
    }
    
    /*
     
     Function: start
     Parameters: none
     
     What does : Provide a lable telling user to tap to start the game.
                After user taps, the lable disapear annd player stops breathing animation,starts running
                Also the bridge moves and blocks generates every 1 seconds
     
     ** Developper can change the time of blocks generating as they want
     
    */
    
    func start(){
        
        isGameStarted = true
        let tapToStartLable = childNode(withName: "tapToStartLabel")
                                tapToStartLable?.removeFromParent()
        player.stop()
        player.startRunning()
        movingBridge.start()
        blocksGenerator.startBlocksGenaratingIsEvery(seconds: 1)
        
        
    }
    
    /*
     
     Function: gameOver
     
     Parameters : none
     
     What does: This function will stop everything after player hits a block
                User can restart the game by tapping on the label(gameOverLabel)
     
 
   */
    
    func gameOver(){
        
        isGameOver = true
        player.physicsBody = nil
        blocksGenerator.stopBlocks()
        movingBridge.stop()
        player.stop()
        
        let gameOverLabel = SKLabelNode(text: "Ops! You are dead!")
        gameOverLabel.name = "gameOverLabel"
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        gameOverLabel.fontColor = UIColor.white
        gameOverLabel.fontSize = 100
        self.addChild(gameOverLabel)
        
        
    }
    
    
    func restart (){
        
       let  newScene = GameScene(size: CGSize(width: 1536, height: 2048))
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
        
    }
    
    
    /*
     Funtion : didBegin
     
     This funtion will detect every time when the user hits a block
     
     ** Developpers can use  "print("did began called")" to see if the game
     workd correctly
     
    */
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        gameOver()
        //print("did began called")
    }
    
    /*
     Funtion: touchesBegan
     
 
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isGameOver {
            restart ()
        }
        
       else  if !isGameStarted {
            start()
            
        }else {
           // player.jump()
        }
        
        
    }
}
