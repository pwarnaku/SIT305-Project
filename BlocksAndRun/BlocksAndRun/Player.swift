//
//  Player.swift
//  BlocksAndRun
//
//  Created by Piumi on 2/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    /*
        Body parts of the player
        These parts will be used to animate the player
    */
    
    var body: SKSpriteNode!
    var arms: SKSpriteNode!
    var leftLeg: SKSpriteNode!
    var rightLeg: SKSpriteNode!
    
    
    // initial size of the player
     init() {
        
        super.init(texture: nil, color: UIColor.blue, size: CGSize(width: 32, height: 42))
    }
        
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
