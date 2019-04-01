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
    
    // this function will run as soon as the screen loads-up [piumi]
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2) //get the center point for the position
        background.zPosition = 0
        
        self.addChild(background) // makes the background
        
        
        
        movingBridge = MovingBridge(size: CGSize(width: self.size.width, height: 120))
        
        movingBridge.position = view.center
        movingBridge.zPosition = 1
        self.addChild(movingBridge)
        
        
        // let player = SKSpriteNode(imageNamed: "player-run")
        // player.setScale(1)
        //  player.position = CGPoint(x: self.size.width/3, y: self.size.height/5)
        //player.zPosition = 2
        
        // self.addChild(player)// creates the player
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        movingBridge.start() // this will call the funtion ( start)
        
    }
}
