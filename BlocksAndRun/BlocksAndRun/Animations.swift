//
//  Animations.swift
//  BlocksAndRun
//
//  Created by Piumi on 29/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import SpriteKit

public class Animations: SKSpriteNode {

    var mainRunningAnimation: SKSpriteNode!
    var textureAtlas = SKTextureAtlas()
    var textureArray = [SKTexture]()
    
    
    var burningAnimation: SKSpriteNode!
    var burningTextureAtlas = SKTextureAtlas()
    var burningTextureArray = [SKTexture]()

    func man1RunningAnimation(){
        
        textureAtlas = SKTextureAtlas(named: "running")
        
        for i in 1...textureAtlas.textureNames.count{
            
            let imageName = "run\(i)"
            textureArray.append(SKTexture(imageNamed: imageName))
        }
        
        mainRunningAnimation = SKSpriteNode(imageNamed: textureAtlas.textureNames[0] as! String)
        mainRunningAnimation.size = CGSize(width: 300, height: 600)
        mainRunningAnimation.position = CGPoint(x: self.size.width/2, y: 80)
        mainRunningAnimation.zPosition = 2
        
        self.addChild(mainRunningAnimation)
        
        
        mainRunningAnimation.run(SKAction.repeatForever(SKAction.animate(with: textureArray, timePerFrame: 0.07)))
    }
    
    /*
     
     Function: burn
     
     Purpose: This funtion is to add a texture after player hits a fire to look like he is buring
     I have added a gif to make it looks like real
     
     ** Important note for developers**
     This function is called in gamescene.swift file under gameOver function.
     
     */
    
    func burning()  {
        
        burningTextureAtlas = SKTextureAtlas(named: "burning")
        
        for i in 1...burningTextureAtlas.textureNames.count
        {
            
            let imageName = "burning\(i)"
            burningTextureArray.append(SKTexture(imageNamed: imageName))
        }
        
        burningAnimation = SKSpriteNode(imageNamed: burningTextureAtlas.textureNames[0] as! String)
        burningAnimation.size = CGSize(width: 400, height: 700)
        burningAnimation.position = CGPoint(x: self.size.width/2, y: 140)
        burningAnimation.zPosition = 2
        
        self.addChild(burningAnimation)
        
        
        burningAnimation.run(SKAction.repeatForever(SKAction.animate(with: burningTextureArray, timePerFrame: 0.07)))
        
    }
    
    func scalingAnimation() -> SKAction{
        
        //let delayAction = SKAction.wait(forDuration: TimeInterval(index) * 0.2)
        
        // Scale up and then back down
        let scaleUpAction = SKAction.scale(to: 1.5, duration: 0.3)
        let scaleDownAction = SKAction.scale(to: 1, duration: 0.3)
        
        // Wait for 2 seconds before repeating the action
        let waitAction = SKAction.wait(forDuration: 2)
        
        // Form a sequence with the scale actions, as well as the wait action
        let scallingSequence = SKAction.sequence([scaleUpAction, scaleDownAction, waitAction])
        
        return SKAction.repeatForever(scallingSequence)
        
        
        // Combine the delay and the repeat actions into another sequence
        // let actionSequence = SKAction.sequence([delayAction, repeatAction])
        
        // Run the action
        

}

}
