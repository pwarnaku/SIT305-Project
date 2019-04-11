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
    var blocks = [Blocks]() // created an empty array
    
    
    /*
     
     Function: startBlocksGenaratingIsEvery
     Parameters: TimeInterval
     
     Definition:
     
     1. TimeInterval - Time interval that blocks come
     
     
     
     
     */
    
    func startBlocksGenaratingIsEvery(seconds: TimeInterval)  {
        
        blockGenarateTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(BlocksGenarator.generateBlocks), userInfo: nil, repeats: true)
        //generateBlocks ()
        
    }
    
    
    
    /*
     Function: generateBlocks
     Parameters: none
     
     
     Purpose: This funtion will generate blocks randomly and
     set up the positions of blocks
     
     */
    
    @objc func generateBlocks (){
        
        //var scale:CGFloat
        
        var scale: CGFloat
        
        let rand = arc4random_uniform(2)
        if rand == 0 {
            scale = -5.0
        } else {
            scale = 1.0
        }
        
        let block = Blocks()
        
        
        
        block.position.x = 1000
        block.position.y = scale * 130
        blocks.append(block)
        addChild(block)
        
        let fireEmitter = SKEmitterNode(fileNamed: "Fire")!
       // fireEmitter.position = block.position
        block.addChild(fireEmitter)
    }
    
    /*
     
     Function: stopGeneratingBlocks
     Parameters: none
     
     What does: This funtion wil stop generating walls after user hits a block.
     invalidate() this method will stop the generation timer
     
     */
    
    func stopGeneratingBlocks (){
        
        blockGenarateTimer?.invalidate()
    }
    
    /*
     
     Function: stopBlocks
     Parameters: none
     
     Does: This function will stop every block in "blocks" array
     
     */
    
    func stopBlocks(){
        stopGeneratingBlocks ()
        
        for block in blocks {
            block.stopMoving()
        }
    }
}

