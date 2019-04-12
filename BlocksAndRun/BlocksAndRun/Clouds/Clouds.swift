//
//  Clouds.swift
//  BlocksAndRun
//
//  Created by Piumi on 9/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import SpriteKit

class Clouds : SKSpriteNode {
    
    /*
     
     Function init
     
     Purpose: This funtion will give the innitial appearence of the clouds.
     
     */
    
    init(size: CGSize) {
        
        let cloudTexture = SKTexture(imageNamed: "cloud")
        let size = CGSize(width: 300 ,height : 100)
        super.init(texture: cloudTexture, color: UIColor.clear, size: size )
        
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
     
     Function: startMoving
     Parameters: none
     
     Purpose : This function is to move each cloud by given -x value defaultBlocksmoveByxperSeconds
    
     
     run(SKAction.repeatForever(moveLeft)) will keep moving the blocks during an unlimited time
     
     ** Important note for developers**
     Developer can change the speed of moving as they want by changing the "adjustDuration".
     "defaultBlocksmoveByxperSeconds" is declared in constants.swift file
     
     */
    
    func startMoving()
    {
        let moveLeft = SKAction.moveBy(x: -20, y: 0, duration: 1)
        run(SKAction.repeatForever(moveLeft))
    }
}
