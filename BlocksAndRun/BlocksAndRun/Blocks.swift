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
    let BLOCKS_HEIGHT = 400.00
    let WALL_COLOUR = UIColor.black
    
    init(){
        
        let size = CGSize(width: BLOCKS_WIDTH ,height : BLOCKS_HEIGHT)
        super.init(texture: nil, color: WALL_COLOUR, size: size )
        startMoving()
        loadPhisycBodyWithSize(size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadPhisycBodyWithSize(size: CGSize){
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = bridgeCategory
        
        physicsBody?.affectedByGravity = false
        
    }
    
    func startMoving ()  {
        let moveleft = SKAction.moveBy(x: -defaultBlocksmoveByxperSeconds, y: 0, duration: 1)
        run(SKAction.repeatForever(moveleft))
    }
}

