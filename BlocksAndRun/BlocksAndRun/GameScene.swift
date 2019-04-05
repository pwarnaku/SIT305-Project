//
//  GameScene.swift
//  BlocksAndRun
//
//  Created by Piumi on 25/3/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var movingBridge: MovingBridge!
    var player: Player!
    var blocksGenerator: BlocksGenarator!
    var isStarted = false
    
    /*this function will run as soon as the screen loads-up
     
     
     */
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2) //get the center point for the position
        background.zPosition = 0
        self.addChild(background) // makes the background
        
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
        /*
        blocksGenerator = BlocksGenarator(color: UIColor.black, size: view.frame.size)
        blocksGenerator.position = view.center
        addChild(blocksGenerator)
        
        */
        // let player = SKSpriteNode(imageNamed: "player-run")
        // player.setScale(1)
        //  player.position = CGPoint(x: 70, y: movingBridge.position.y + movingBridge.frame.size.height/2 + player.frame.size.height/2)
        //player.zPosition = 2
        
        // self.addChild(player)// creates the player
        
    }
    func start(){
        
        isStarted = true
        player.stop()
        player.startRunning()
        movingBridge.start()
//        blocksGenerator.startBlocksGenaratingIsEvery(seconds: 1)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !isStarted {
            start()
            
        }else {
           // player.jump()
        }
        
        
    }
}
