//
//  Blocks.swift
//  BlocksAndRun
//
//  Created by Piumi on 5/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import SpriteKit

class Blocks : SKSpriteNode {
    
    
    let BLOCKS_WIDTH = 100.00
    let BLOCKS_HEIGHT = 300.00
    let WALL_COLOUR = UIColor.black
    
    init(){
        
        let blockTexture = SKTexture(imageNamed: "fire")
        let size = CGSize(width: BLOCKS_WIDTH ,height : BLOCKS_HEIGHT)
        super.init(texture: nil, color: UIColor.black, size: size )
        loadPhisycBodyWithSize(size: size)
        startMoving()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     
     Function: loadPhisycBodyWithSize
     Parameters : Size of the player
     
     what does : loads the physics body with the given size surounding a rectangle.
     when the player playerCategory)  hits a block (blockeCategory) it will be recorded
     as a contact
     
     ** Important - This funtion is also implemented in player.swift class.
     Therefore no need to write "contactTestBitMask" methode again
     
     */
    
    func loadPhisycBodyWithSize(size: CGSize){
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = blockeCategory
        
        physicsBody?.affectedByGravity = false
        
    }
    
    func startMoving ()  {
        let moveleft = SKAction.moveBy(x: -defaultBlocksmoveByxperSeconds, y: 0, duration: 1)
        run(SKAction.repeatForever(moveleft))
    }
    
    /*
     This funtion is called inblocksGeneration class to stop generating blocks
     after the user hits a block
     
     */
    func stopMoving(){
        removeAllActions()
    }
}

