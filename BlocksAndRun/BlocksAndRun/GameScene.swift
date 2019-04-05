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
     This function will run as soon as the screen loads-up
     creates the background , bridge, player and blocks ~ Piumi
     
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
        
       
        
    }
    
    
    func start(){
        
        isGameStarted = true
        let tapToStartLable = childNode(withName: "tapToStartLabel")
        tapToStartLable?.removeFromParent()
        player.stop()
        player.startRunning()
        movingBridge.start()
        blocksGenerator.startBlocksGenaratingIsEvery(seconds: 1)
        
        
    }
    
    func gameOver(){
        
        isGameOver = true
        
        // stops everything after gameis over
        
        player.physicsBody = nil
        
        blocksGenerator.stopBlocks()
    }
    
    /* This funtion will detect every time when the user hits a block
    */
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        gameOver()
        print("did began called")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !isGameStarted {
            start()
            
        }else {
           // player.jump()
        }
        
        
    }
}
