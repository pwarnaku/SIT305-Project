 //
//  BlocksGenarator.swift
//  BlocksAndRun
//
//  Created by Piumi on 5/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import SpriteKit

class BlocksGenarator: SKSpriteNode {
    var blockGenarateTimer : Timer?
    
    func startBlocksGenaratingIsEvery(seconds: TimeInterval)  {
        
        blockGenarateTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(BlocksGenarator.generateBlocks), userInfo: nil, repeats: true)
        //generateBlocks ()
        
    }
    
    
    
    /*
     This funtion will generate blocks , set up the positions of blocks
     */
    @objc func generateBlocks (){
        
        //var scale:CGFloat
        
        var scale: CGFloat
        
        let rand = arc4random_uniform(2)
        if rand == 0 {
            scale = -1.0
        } else {
            scale = 1.0
        }
        
        let block = Blocks()
        
        block.position.x = size.width/2 + block.size.width/2
        block.position.y = scale * (120/2 + block.size.height/2)
        addChild(block)
    }
}

