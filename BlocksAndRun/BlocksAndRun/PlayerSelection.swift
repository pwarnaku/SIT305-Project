//
//  PlayerSelection.swift
//  BlocksAndRun
//
//  Created by Piumi on 28/4/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import GameplayKit


class PlayerSelection: SKScene  {
  
  //  weak var scrollView: CustomScrollView!
    let moveableNode = SKNode()
    
    var textureAtlas1 = SKTextureAtlas()
    var textureArray1 = [SKTexture]()
    
    var textureAtlas2 = SKTextureAtlas()
    var textureArray2 = [SKTexture]()
    
    var backgroundSegment1: SKSpriteNode!
    var backgroundSegment2: SKSpriteNode!
    var man1: SKSpriteNode!
    var man2: SKSpriteNode!
    
    var button1: SKSpriteNode!
    
    /*
     
     Function: didMove
     Parameters: SKView
     
     Purpose: This function will run as soon as the screen loads-up
     creates all elements of the scene
     
     "CGPoint" method is use for positioning all the elements inside od the view
     
     **Important note for developpers**
     Developers can user a image instead of using a color. to do that remove nil form "texture" and
     add SKTexture textureWithImage:[UIImage imageNamed:"imagename.png"]
     
     */
    
    
    override func didMove(to view: SKView) {
        
        
        
        
        let background = SKSpriteNode(color: UIColor(red: 69.00/255.0, green: 161.00/255.0, blue: 161.00/255.0, alpha: 5.0), size: CGSize(width: 700, height: 700))
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        
        backgroundSegment1 = SKSpriteNode(color: UIColor(red: 137.0/255.0, green: 165.0/255.0, blue: 165.0/255.0, alpha: 5.0), size: CGSize(width: 720, height: 450))
        backgroundSegment1.position = CGPoint(x:760, y: 1300)
        //self.isUserInteractionEnabled = true
        addChild(backgroundSegment1)
        
        textureAtlas1 = SKTextureAtlas(named: "running")
        
        for i in 1...textureAtlas1.textureNames.count{
            
            let imageName1 = "run\(i)"
            textureArray1.append(SKTexture(imageNamed: imageName1))
        }
        
        man1 = SKSpriteNode(imageNamed: textureAtlas1.textureNames[0] as! String)
        man1.size = CGSize(width: 300, height: 600)
        man1.position = CGPoint(x: 600, y: 1300)
        man1.zPosition = 10
        
        self.addChild(man1)
        
        
        man1.run(SKAction.repeatForever(SKAction.animate(with: textureArray1, timePerFrame: 0.06)))
        
        
        
        backgroundSegment2 = SKSpriteNode(color: UIColor(red: 137.0/255.0, green: 165.0/255.0, blue: 165.0/255.0, alpha: 5.0), size: CGSize(width: 720, height: 450))
        backgroundSegment2.position = CGPoint(x:760, y: 800)
        //self.isUserInteractionEnabled = true
        addChild(backgroundSegment2)
        
        textureAtlas2 = SKTextureAtlas(named: "man2")
        
        for i in 1...textureAtlas2.textureNames.count{
            
            let imageName = "man\(i)"
            textureArray2.append(SKTexture(imageNamed: imageName))
        }
        
        man1 = SKSpriteNode(imageNamed: textureAtlas2.textureNames[0] as! String)
        man1.size = CGSize(width: 300, height: 600)
        man1.position = CGPoint(x: 600, y: 800)
        man1.zPosition = 10
        
        self.addChild(man1)
        
        
        man1.run(SKAction.repeatForever(SKAction.animate(with: textureArray2, timePerFrame: 0.06)))
    }
    

}
