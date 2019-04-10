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
    
    
    init(size: CGSize) {
        // super.init()
        
        /* let path = CGPath(ellipseIn: CGRect(x:0, y:0, width: 300, height:100), transform: nil)
         self.path = path
         fillColor = UIColor.white
         fillTexture = SKTexture(imageNamed: "clouds") */
        let cloudTexture = SKTexture(imageNamed: "cloud")
        let size = CGSize(width: 300 ,height : 100)
        super.init(texture: cloudTexture, color: UIColor.clear, size: size )
        
        startMoving()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving()
    {
        let moveLeft = SKAction.moveBy(x: -20, y: 0, duration: 1)
        run(SKAction.repeatForever(moveLeft))
    }
}
