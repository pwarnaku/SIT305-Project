//
//  Birds.swift
//  BlocksAndRun
//
//  Created by Piumi on 30/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import SpriteKit

class Birds  {
    
    
    var speed:Float = 0.0
    var guy:SKSpriteNode
    var currentFrame = 0
    var randomFrame = 0
    var moving = false
    var angle = 0.0
    var range = 2.0
    var yPos = CGFloat()
    
    init(speed:Float,guy:SKSpriteNode) {
        self.speed = speed
        self.guy = guy
        self.setRandomFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRandomFrame() {
        var range = UInt32(50)..<UInt32(200)
        self.randomFrame = Int(range.startIndex + arc4random_uniform(range.endIndex - range.startIndex + 1))
    }
}

