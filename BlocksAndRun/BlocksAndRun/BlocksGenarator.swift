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
    
    func startBlocksGenaratingIsEvery(seconds: TimeInterval)  {
        
        blockGenarateTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(BlocksGenarator.generateBlocks), userInfo: nil, repeats: true)
        //generateBlocks ()
        
    }
    
    
    
    /*
     This funtion will generate blocks randomly  , set up the positions of blocks
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
        blocks.append(block)
        addChild(block)
    }
    
    /* This funtion wil stop generating walls after user hits a block
     
     invalidate() this method will stopthe generation timer
     
    */
    func stopGeneratingBlocks (){
        
        blockGenarateTimer?.invalidate()
        
    }
    
    /*
     
    */
    
    func stopBlocks(){
        stopGeneratingBlocks ()
        
        for block in blocks {
            block.stopMoving()
        }
    }
}

