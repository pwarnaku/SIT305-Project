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
    
    
    let BLOCKS_WIDTH = 400.00
    let BLOCKS_HEIGHT = 500.00
    let WALL_COLOUR = UIColor.black
    
    /*
    
    Function init
     
    Purpose: This funtion will give the innitial appearence of the block.
     
   */
    
    init(){
        
        let size = CGSize(width: BLOCKS_WIDTH ,height : BLOCKS_HEIGHT)
        super.init(texture: nil, color: UIColor.clear, size: size )
        loadPhisycBodyWithSize(size: size)
        startMoving()
        
    }
    
    /*
     Function: required init?(coder aDecoder: NSCoder)
     
     Purpose: This is a default function comes wity ithe init
     
     */
    
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
    
    /*
     
     Function: startMoving
     Parameters: none
     
     Purpose : This function is to move each block by given -x value defaultBlocksmoveByxperSeconds
     After user taps, the lable disapear annd player stops breathing animation,starts moving
     
     
     run(SKAction.repeatForever(moveSequence)) will keep moving the blocks during an unlimited time
     
     ** Important note for developers**
     Developer can change the speed of moving as they want by changing the "adjustDuration".
     "defaultBlocksmoveByxperSeconds" is declared in constants.swift file
     
     */
    
    func startMoving ()  {
        let moveleft = SKAction.moveBy(x: -defaultBlocksmoveByxperSeconds, y: 0, duration: 1)
        run(SKAction.repeatForever(moveleft))
    }
    
    
     /*
     
     Function: stop
     
     Parameters: none
     
     Purpose: This funtion will stop blocks moving.
     
     ** Important note for developers**
     
     This function is called in gamescene.swift file under gameOver() function.
     after hiting a block bridge will stop moving
     
     */
     
 
    func stopMoving(){
        removeAllActions()
    }
}

