//
//  MovingBridge.swift
//  BlocksAndRun
//
//  Created by Piumi on 1/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import SpriteKit

class MovingBridge : SKSpriteNode{
    
    let NUMBER_OF_SEGMENTS = 20
    
    /*
     Function : init
     
     Parameters: size: CGSize
     
     Definition of parameters: innitial size of the bridge
     
     Purpose: This funtion will give the innitial appearence of the bride.
     first I declared a variable to assign number of segments of the bridge and then I have ussed a for loop to assign a texture to each segment. So user can see bridge is actually moving.
     
     **Important note for developpers**
     Developpers can use  solid colours instead of using a texture. in order to do that
     declare colours and give values like following,
     
     let COLOR_ONE = UIColor(red: 47.0/255.0, green: 79.0/255.0, blue: 79.0/255.0, alpha: 1.0)
     let COLOR_TWO = UIColor(red: 0.0/255.0, green: 0.0/255.00, blue: 1.0/255.0, alpha: 1.0)
     
     
    */
    
    init(size: CGSize) {
        
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: size.width*2, height: 620))
        anchorPoint = CGPoint(x: 0.0, y: 0.5)
        // anchorPoint = CGPoint(0.00,0.50)
        
        for i in 0 ..< NUMBER_OF_SEGMENTS
            
        {
            let segment1 = SKTexture(imageNamed: "bridgeSegmentOne")
            let segment2 = SKTexture(imageNamed: "bridgeSegmentOne")
            if i % 2 == 0 {
                
                let segment = SKSpriteNode(texture:segment1,size: CGSize(width: self.size.width/CGFloat(NUMBER_OF_SEGMENTS), height: 620))
                segment.anchorPoint = CGPoint(x: 0.0, y: 0.5)
                segment.position = CGPoint(x: CGFloat(i)*segment.size.width, y: 0.0)
                
                addChild(segment)
                
            }
            else
            {
                let segment = SKSpriteNode(texture: segment2,size: CGSize(width: self.size.width/CGFloat(NUMBER_OF_SEGMENTS), height: 620))
                segment.anchorPoint = CGPoint(x: 0.0, y: 0.5)
                segment.position = CGPoint(x: CGFloat(i)*segment.size.width, y: 0.0)
                
                addChild(segment)
                
            }
          
            
        }
    }
    
    /*
     Function: required init?(coder aDecoder: NSCoder)
     
     Purposez: This is a default function comes wity ithe init
     
    */
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     
    Function: start
    Parameters: none
    
    Purpose : This function is tomove each segemnts by given -x value (frame.size.width)
    After user taps, the lable disapear annd player stops breathing animation,starts moving
   
     
    run(SKAction.repeatForever(moveSequence)) will keep moving the bridge during an unlimited time
    
    ** Important note for developers**
    Developer can change the speed of moving as they want by changing the "adjustDuration".
    "defaultBlocksmoveByxperSeconds" is declared in constants.swift file
    
    */
    
    func  start(){
        
        let adjustDuration = TimeInterval(frame.size.width/defaultBlocksmoveByxperSeconds)
        let moveLeft = SKAction.moveBy(x: -frame.size.width/2, y: 0, duration: adjustDuration)
        let resetPosition = SKAction.moveTo(x: 0, duration: 0)
        let moveSequence = SKAction.sequence([moveLeft,resetPosition])
        run(SKAction.repeatForever(moveSequence))
    }
    
    
    /*
     
     Function: stop
     
     Parameters: none
     
     Purpose: This funtion will stop moving.
     
     ** Important note for developers**
     
     This function is called in gamescene.swift file under gameOver() function.
     after hiting a block bridge will stop moving
     
    */
    
    func stop()  {
        removeAllActions()
    }
}

