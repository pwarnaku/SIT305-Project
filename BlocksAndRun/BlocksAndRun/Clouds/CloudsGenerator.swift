//
//  CloudsGenerator.swift
//  BlocksAndRun
//
//  Created by Piumi on 3/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import SpriteKit

class CloudsGenarator: SKSpriteNode {
    
    
    let CLOUD_WIDTH = 250.00
    let CLOUD_HEIGHT = 70.00
    var cloudsGenarateTimer : Timer?
    
    /*
     
     Function: populate
     Parameters: num: Int
     
     Purpose: This funtion will generate clouds with given time
     
     ** Important note for developers**
     
     This function is called in gamescene.swift and startScene.swift files under didMove function.
     
     */
    
    func populate(num: Int)
    {
        for i in 0 ..< num
        {
            
            let cloud = Clouds(size: CGSize(width: CLOUD_WIDTH, height:CLOUD_HEIGHT))
            let x = CGFloat(arc4random_uniform(UInt32(size.width))) - size.width/2
            let y = CGFloat(arc4random_uniform(UInt32(size.width))) - size.height/2
            cloud.position = CGPoint(x:x, y:y)
            cloud.zPosition = 0
            addChild(cloud)
            
        }
    }
    
    /*
     
     Function: stratGeneratingwithSpawnTime
     Parameters: TimeInterval
     
     Purpose: This funtion will generate clouds with given time

     */
    
    func stratGeneratingwithSpawnTime(seconds: TimeInterval)
    {
        let x = size.width/2 + 250/2
        let y = CGFloat(arc4random_uniform(UInt32(size.height)))-size.height/2
        let cloud = Clouds(size: CGSize(width: CLOUD_WIDTH, height: CLOUD_HEIGHT ))
        cloud.position = CGPoint(x: x, y:y)
        
        addChild(cloud)
    }
    
    /*
     
     Function: stopGeneratingClouds
     Parameters: none
     
     Purpose: This funtion wil stop generating walls after user hits a block.
     invalidate() this method will stop the generation timer
     
     ** Important note for developers**
     This function is called in gamescene.swift file under gameOver function.
     
     */
    
    func stopGeneratingClouds(){
        
        cloudsGenarateTimer?.invalidate()
    }
    
    
    
}


