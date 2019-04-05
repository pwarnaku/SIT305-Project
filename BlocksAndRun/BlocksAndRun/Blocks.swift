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
    let BLOCKS_HEIGHT = 100.00
    let WALL_COLOUR = UIColor.clear
    
    init(){
        
        super.init(texture: nil, color: WALL_COLOUR, size: CGSize(width: BLOCKS_WIDTH ,height : BLOCKS_HEIGHT))
        startMoving()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving ()  {
        let moveleft = SKAction.moveBy(x: -300, y: 0, duration: 1)
        run(SKAction.repeatForever(moveleft))
    }
}

