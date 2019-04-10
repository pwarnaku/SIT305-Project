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
    
    //let color = SKTexture(imageNamed: "leftLeg")
    
    /*
     I have use segments to show as the bridge is moving. the preview of the bridge will completely change
     */
    
    
    let NUMBER_OF_SEGMENTS = 20
    let COLOR_ONE = UIColor(red: 47.0/255.0, green: 79.0/255.0, blue: 79.0/255.0, alpha: 1.0)
    let COLOR_TWO = UIColor(red: 0.0/255.0, green: 0.0/255.00, blue: 1.0/255.0, alpha: 1.0)
    
    
    
    init(size: CGSize) {
        let bridgeTexture = SKTexture(imageNamed: "bridgeSegmentOne")
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: size.width*2, height: 320))
        anchorPoint = CGPoint(x: 0.0, y: 0.5)
        // anchorPoint = CGPoint(0.00,0.50)
        
        for i in 0 ..< NUMBER_OF_SEGMENTS
        {
            let segment1 = SKTexture(imageNamed: "bridgeSegmentOne")
            let segment2 = SKTexture(imageNamed: "bridgeSegmentOne")
            if i % 2 == 0 {
                
                let segment = SKSpriteNode(texture:segment1,size: CGSize(width: self.size.width/CGFloat(NUMBER_OF_SEGMENTS), height: 320))
                segment.anchorPoint = CGPoint(x: 0.0, y: 0.5)
                segment.position = CGPoint(x: CGFloat(i)*segment.size.width, y: 0.0)
                
                addChild(segment)
                // segmentColor = COLOR_ONE
            }
            else
            {
                let segment = SKSpriteNode(texture: segment2,size: CGSize(width: self.size.width/CGFloat(NUMBER_OF_SEGMENTS), height: 320))
                segment.anchorPoint = CGPoint(x: 0.0, y: 0.5)
                segment.position = CGPoint(x: CGFloat(i)*segment.size.width, y: 0.0)
                
                addChild(segment)
                
            }
            //CGFloat(i)*segment.size.width,0
            
            
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  start(){
        
        let adjustDuration = TimeInterval(frame.size.width/defaultBlocksmoveByxperSeconds)
        
        let moveLeft = SKAction.moveBy(x: -frame.size.width/2, y: 0, duration: 1.0)
        
        let resetPosition = SKAction.moveTo(x: 0, duration: 0)
        
        let moveSequence = SKAction.sequence([moveLeft,resetPosition])
        
        run(SKAction.repeatForever(moveSequence))
    }
    
    func stop()  {
        removeAllActions()
    }
}

