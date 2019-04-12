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
     
     1. TimeInterval - Time interval that blocks generate
     
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
     
      ** Important note for developers**
     
     arc4random_uniform - This method generate random numbers from 0 to given number.
     I have use scale to assign 1.0 or -1.0. The purpose of having theese values is to assign them into
     blocks as their positions. -1.0 meaning that block will generate upside dowm of the bridge.
     
     I have use a emitter here andadded into each block.
     
     */
    
    @objc func generateBlocks (){
        
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
        block.addChild(fireEmitter)
    }
    
    /*
     
     Function: stopGeneratingBlocks
     Parameters: none
     
     Purpose: This funtion wil stop generating walls after user hits a block.
     invalidate() this method will stop the generation timer
     
     ** Important note for developers**
     This function is called in gamescene.swift file under gameOver function.
     
     */
    
    func stopGeneratingBlocks (){
        
        blockGenarateTimer?.invalidate()
    }
    
    /*
     
     Function: stopBlocks
     Parameters: none
     
     Purpose: This function will stop every block in "blocks" array
     
     ** Important note for developers**
     This function is called in gamescene.swift file under gameOver function.
     
     
     */
    
    func stopBlocks(){
        stopGeneratingBlocks ()
        
        for block in blocks {
            block.stopMoving()
        }
    }
}

